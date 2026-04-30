using Aoun.BLL.DTOs.Auth;
using Aoun.BLL.DTOs.Case;
using Aoun.BLL.Interfaces.Admin;
using Aoun.DAL.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;


namespace Aoun.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = nameof(UserType.Admin))]
[Authorize(Roles = "Admin")]
public class VerifyDto
{
    public string Status { get; set; } = string.Empty; 
}
[Authorize(Roles = "Admin")]
public class AdminController : ControllerBase
{
    private readonly IAdminService _adminService;

    public AdminController(IAdminService adminService) => _adminService = adminService;

    [HttpGet("stats")]
    public async Task<IActionResult> GetStats() => Ok(await _adminService.GetStatsAsync());

    [HttpGet("charities")]
    public async Task<IActionResult> GetAllCharities() => Ok(await _adminService.GetAllCharitiesAsync());

    [HttpGet("charities/{id:int}")]
    public async Task<IActionResult> GetCharityById(int id) => Ok(await _adminService.GetCharityByIdAsync(id));

    [HttpPut("verify-charity/{id}")]
    public async Task<IActionResult> VerifyCharity(int id, [FromBody] VerifyDto model)
    {
        var result = await _adminService.UpdateStatusAsync(id, model.Status == "approve" ? 1 : 2);

        if (result) return Ok(new { message = "Status updated successfully" });
        return BadRequest("Failed to update charity status");
    }

    [HttpPut("status/{id:int}")]
    public async Task<IActionResult> UpdateStatus(int id, [FromBody] int status) => Ok(await _adminService.UpdateStatusAsync(id, status));

    [HttpGet("cases")]
    public async Task<IActionResult> GetAllCases() => Ok(await _adminService.GetAllCasesAsync());

   // [HttpDelete("cases/{id:int}")]
    // public async Task<IActionResult> DeleteCase(int id) => Ok(await _adminService.DeleteCaseAsync(id));
    
    [HttpPost("cases")]
public async Task<IActionResult> CreateCase([FromBody] CaseCreateDto dto)
    => Ok(await _adminService.CreateCaseAsync(dto));

[HttpPut("cases/{id}")]
public async Task<IActionResult> UpdateCase(int id, [FromBody] CaseUpdateDto dto)
    => Ok(await _adminService.UpdateCaseAsync(id, dto));

[HttpDelete("cases/{id}")]
public async Task<IActionResult> DeleteCase(int id)
    => Ok(await _adminService.DeleteCaseAsync(id));

[HttpGet("top-donors")]
public async Task<IActionResult> TopDonors()
    => Ok(await _adminService.GetTopDonorsAsync());

[HttpGet("top-charities")]
public async Task<IActionResult> TopCharities()
    => Ok(await _adminService.GetTopCharitiesAsync());
}




