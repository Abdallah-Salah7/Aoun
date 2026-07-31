using Aoun.BLL.DTOs.Auth;
using Aoun.BLL.DTOs.Document;
using Aoun.BLL.DTOs.Profile;
using Aoun.BLL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace Aoun.API.Controllers.Charity;

[Route("api/[controller]")]
[ApiController]
[Authorize] // حماية الشاشة دي بالتوكن
public class CharityController : ControllerBase {
    private readonly ICharityService _charity;
    public CharityController(ICharityService charity) => _charity = charity;

    private string GetUserId() => User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "";

    [HttpPost("complete-profile")] public async Task<IActionResult> Complete(CharityRegistrationDto model) => Ok(await _charity.CompleteProfileAsync(model, GetUserId()));
    [HttpPost("upload-document")]
public IActionResult UploadDocument([FromBody] UploadDocumentDto model)
{
    if (model == null || string.IsNullOrWhiteSpace(model.Url))
        return BadRequest("Url is required");

    return Ok(model.Url);
}
}
