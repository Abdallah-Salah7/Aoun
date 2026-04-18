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
            return new AuthResponseDto { IsSuccess = false, Message = "البريد الإلكتروني وكلمة المرور مطلوبان" };
        }

        var existingUser = await _userManager.FindByEmailAsync(req.Email.Trim());
        if (existingUser != null)
        {
            return new AuthResponseDto { IsSuccess = false, Message = "البريد الإلكتروني مستخدم بالفعل" };
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
            Message = "تم التسجيل بنجاح! يمكنك الآن تسجيل الدخول أو تأكيد البريد من خلال التوكن.",
            Token = GenerateToken(user)
        };
    }

    public async Task<AuthResponseDto> LoginAsync(LoginRequestDto req)
    {
        var user = await _userManager.FindByEmailAsync(req.Email.Trim());
        if (user == null || !await _userManager.CheckPasswordAsync(user, req.Password))
        {
            return new AuthResponseDto { IsSuccess = false, Message = "بيانات الدخول خاطئة" };
        }

        return new AuthResponseDto
        {
            IsSuccess = true,
            Message = "تم تسجيل الدخول",
            Token = GenerateToken(user)
        };
    }

    public async Task<AuthResponseDto> ForgotPasswordAsync(ForgotPasswordDto model)
    {
        var user = await _userManager.FindByEmailAsync(model.Email.Trim());
        if (user == null)
        {
            return new AuthResponseDto { IsSuccess = false, Message = "البريد الإلكتروني غير مسجل" };
        }

        var token = await _userManager.GeneratePasswordResetTokenAsync(user);
        return new AuthResponseDto { IsSuccess = true, Message = "تم توليد توكن استعادة كلمة المرور", Token = token };
    }

    public async Task<AuthResponseDto> VerifyEmailAsync(VerifyEmailDto model)
    {
        var user = await _userManager.FindByEmailAsync(model.Email.Trim());
        if (user == null)
        {
            return new AuthResponseDto { IsSuccess = false, Message = "البريد الإلكتروني غير مسجل" };
        }

        if (user.EmailConfirmed)
        {
            return new AuthResponseDto { IsSuccess = true, Message = "البريد الإلكتروني مؤكد بالفعل" };
        }

        var result = await _userManager.ConfirmEmailAsync(user, model.Token);
        return result.Succeeded
            ? new AuthResponseDto { IsSuccess = true, Message = "تم تأكيد البريد الإلكتروني بنجاح" }
            : new AuthResponseDto { IsSuccess = false, Message = string.Join(", ", result.Errors.Select(e => e.Description)) };
    }

    public async Task<AuthResponseDto> SocialLoginAsync(SocialLoginDto model)
    {
        var provider = model.Provider.Trim().ToLowerInvariant();
        if (provider is not ("google" or "facebook" or "apple"))
        {
            return new AuthResponseDto { IsSuccess = false, Message = "مزود تسجيل الدخول الاجتماعي غير مدعوم" };
        }

        if (string.IsNullOrWhiteSpace(model.Token))
        {
            return new AuthResponseDto { IsSuccess = false, Message = "توكن تسجيل الدخول الاجتماعي مطلوب" };
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

        return new AuthResponseDto { IsSuccess = true, Message = "تم تسجيل الدخول الاجتماعي", Token = GenerateToken(user) };
    }

   private string GenerateToken(ApplicationUser user)
{
    var secret = _config["JwtSettings:Secret"];
    if (string.IsNullOrWhiteSpace(secret))
    {
        throw new InvalidOperationException("JwtSettings:Secret is missing.");
    }

    // 🔥 الحل هنا
    var roles = _userManager.GetRolesAsync(user).Result;

    var claims = new List<Claim>
    {
        new Claim(ClaimTypes.NameIdentifier, user.Id),
        new Claim(ClaimTypes.Name, user.FirstName ?? string.Empty),
        new Claim(ClaimTypes.Email, user.Email ?? string.Empty)
    };

    foreach (var role in roles)
    {
        claims.Add(new Claim(ClaimTypes.Role, role));
    }

    var issuer = _config["JwtSettings:Issuer"] ?? "AounApi";
    var audience = _config["JwtSettings:Audience"] ?? "AounAppUsers";

    var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secret));
    var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

    var token = new JwtSecurityToken(
        issuer: issuer,
        audience: audience,
        claims: claims,
        expires: DateTime.UtcNow.AddDays(30),
        signingCredentials: creds);

    return new JwtSecurityTokenHandler().WriteToken(token);
}
}
