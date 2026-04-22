namespace Aoun.BLL.DTOs.Auth;

public class RegisterRequestDto
{
    public string FullName { get; set; } = "";
    public string Email { get; set; } = "";
    public string Password { get; set; } = "";
}

public class RegisterDto : RegisterRequestDto { }

public class LoginRequestDto
{
    public string Email { get; set; } = "";
    public string Password { get; set; } = "";
}

public class AuthResponseDto
{
    public bool IsSuccess { get; set; }
    public string Message { get; set; } = "";
    public string Token { get; set; } = "";
}

public class ForgotPasswordDto
{
    public string Email { get; set; } = "";
}

public class VerifyEmailDto
{
    public string Email { get; set; } = "";
    public string Token { get; set; } = "";
}

public class SocialLoginDto
{
    public string Provider { get; set; } = string.Empty; // google or facebook
    public string Email { get; set; } = string.Empty;
    public string? FullName { get; set; }
    public string Token { get; set; } = string.Empty;
}

public class CharityRegistrationDto
{
    public string CharityName { get; set; } = "";
    public string LicenseNumber { get; set; } = "";
}
