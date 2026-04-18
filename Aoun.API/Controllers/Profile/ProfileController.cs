using Microsoft.AspNetCore.Http;
using Aoun.BLL.DTOs.Profile;
using Microsoft.AspNetCore.Mvc;
using Aoun.BLL.Interfaces.Profile;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

namespace Aoun.API.Controllers;

[Route("api/[controller]")]
[ApiController]
[Authorize]
public class ProfileController : ControllerBase
{
    private readonly IProfileService _profile;

    public ProfileController(IProfileService profile) => _profile = profile;

    private string GetUserId() => User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "";

    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody] UpdateProfileDto model) => Ok(await _profile.UpdateProfileAsync(GetUserId(), model));

    [HttpPut("change-password")]
    public async Task<IActionResult> ChangePass([FromBody] ChangePasswordDto model) => Ok(await _profile.ChangePasswordAsync(GetUserId(), model));

[HttpPost("upload-picture")]
[Consumes("multipart/form-data")]
public async Task<IActionResult> Picture([FromForm] IFormFile file)
{
    if (file == null || file.Length == 0)
        return BadRequest("File is required");

    // مؤقتًا
    return Ok("Uploaded successfully");
}

    [HttpGet("activity")]
    public async Task<IActionResult> Activity() => Ok(await _profile.GetActivityAsync(GetUserId()));


}








