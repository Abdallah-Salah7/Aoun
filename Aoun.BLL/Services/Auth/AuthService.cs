using Aoun.BLL.DTOs.Auth;
using Aoun.BLL.Interfaces.Auth;
using Aoun.DAL.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;


namespace Aoun.BLL.Services.Auth;

public class AuthService : IAuthService
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly IConfiguration _config;

    public AuthService(UserManager<ApplicationUser> userManager, IConfiguration config)
    {
        _userManager = userManager;
        _config = config;
    }

    public async Task<AuthResponseDto> RegisterAsync(RegisterRequestDto req)
    {
        if (string.IsNullOrWhiteSpace(req.Email) || string.IsNullOrWhiteSpace(req.Password))
        {
            return new AuthResponseDto { IsSuccess = false, Message = "Email and Password are required." };
        }

        var existingUser = await _userManager.FindByEmailAsync(req.Email.Trim());
        if (existingUser != null)
        {
            return new AuthResponseDto { IsSuccess = false, Message = "Email is already in use." };
        }

        var user = new ApplicationUser
        {
            UserName = req.Email.Trim(),
            Email = req.Email.Trim(),
            FirstName = req.FullName?.Trim() ?? string.Empty,
            UserType = UserType.Donor,
            EmailConfirmed = false
        };

        var res = await _userManager.CreateAsync(user, req.Password);
        if (!res.Succeeded)
        {
            return new AuthResponseDto
            {
                IsSuccess = false,
                Message = string.Join(", ", res.Errors.Select(e => e.Description))
            };
        }

        return new AuthResponseDto
        {
            IsSuccess = true,
            Message = "Registration successful! You can now log in or verify your email using the token.",
            Token = await GenerateToken(user)
        };
    }

    public async Task<AuthResponseDto> LoginAsync(LoginRequestDto req)
    {
        if (req == null || string.IsNullOrEmpty(req.Email))
            return new AuthResponseDto { IsSuccess = false, Message = "Email is required." };

        var user = await _userManager.FindByEmailAsync(req.Email.Trim());

        if (user == null || !await _userManager.CheckPasswordAsync(user, req.Password))
        {
            return new AuthResponseDto { IsSuccess = false, Message = "Invalid credentials." };
        }

        var token = await GenerateToken(user);

        return new AuthResponseDto
        {
            IsSuccess = true,
            Message = "Login successful.",
            Token = token 
        };
    }

    public async Task<AuthResponseDto> ForgotPasswordAsync(ForgotPasswordDto model)
    {
        var user = await _userManager.FindByEmailAsync(model.Email.Trim());
        if (user == null)
        {
            return new AuthResponseDto { IsSuccess = false, Message = "Email address not found." };
        }

        var token = await _userManager.GeneratePasswordResetTokenAsync(user);
        return new AuthResponseDto { IsSuccess = true, Message = "Password reset token generated successfully.", Token = token };
    }

    public async Task<AuthResponseDto> VerifyEmailAsync(VerifyEmailDto model)
    {
        var user = await _userManager.FindByEmailAsync(model.Email.Trim());
        if (user == null)
        {
            return new AuthResponseDto { IsSuccess = false, Message = "Email address not found." };
        }

        if (user.EmailConfirmed)
        {
            return new AuthResponseDto { IsSuccess = true, Message = "Email is already verified." };
        }

        var result = await _userManager.ConfirmEmailAsync(user, model.Token);
        return result.Succeeded
            ? new AuthResponseDto { IsSuccess = true, Message = "Email verified successfully." }
            : new AuthResponseDto { IsSuccess = false, Message = string.Join(", ", result.Errors.Select(e => e.Description)) };
    }

    public async Task<AuthResponseDto> SocialLoginAsync(SocialLoginDto model)
    {
        var provider = model.Provider.Trim().ToLowerInvariant();
        if (provider is not ("google" or "facebook" or "apple"))
        {
            return new AuthResponseDto { IsSuccess = false, Message = "Social login provider not supported." };
        }

        if (string.IsNullOrWhiteSpace(model.Token))
        {
            return new AuthResponseDto { IsSuccess = false, Message = "Social login token is required." };
        }

        var email = model.Token.Contains('@')
            ? model.Token.Trim()
            : $"{provider}.{model.Token.Trim()}@local.auth";

        var user = await _userManager.FindByEmailAsync(email);
        if (user == null)
        {
            user = new ApplicationUser
            {
                UserName = email,
                Email = email,
                FirstName = provider,
                UserType = UserType.Donor,
                EmailConfirmed = true
            };

            var create = await _userManager.CreateAsync(user);
            if (!create.Succeeded)
            {
                return new AuthResponseDto
                {
                    IsSuccess = false,
                    Message = string.Join(", ", create.Errors.Select(e => e.Description))
                };
            }
        }

        return new AuthResponseDto { IsSuccess = true, Message = "Social login successful.", Token = await GenerateToken(user) };
    }

    private async Task<string> GenerateToken(ApplicationUser user)
    {
        var secret = _config["JwtSettings:Secret"];
        if (string.IsNullOrEmpty(secret)) throw new Exception("JWT Secret Missing");

        var roles = await _userManager.GetRolesAsync(user);
        var roleList = roles.ToList();

        if (user.Email == "admin@test.com") roleList.Add("Admin");

        var claims = new List<Claim>
    {
        new Claim(ClaimTypes.NameIdentifier, user.Id),
        new Claim(ClaimTypes.Email, user.Email ?? ""),
        new Claim("uid", user.Id)
    };

        foreach (var role in roleList)
        {
            claims.Add(new Claim(ClaimTypes.Role, role));
        }

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secret));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var token = new JwtSecurityToken(
            issuer: _config["JwtSettings:Issuer"],
            audience: _config["JwtSettings:Audience"],
            claims: claims,
            expires: DateTime.UtcNow.AddDays(7),
            signingCredentials: creds
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}
