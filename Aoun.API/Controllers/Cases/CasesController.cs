using Microsoft.AspNetCore.Authorization;
using Aoun.BLL.DTOs.Cases;
using Aoun.BLL.Interfaces.Cases;
using Microsoft.AspNetCore.Mvc;

namespace Aoun.API.Controllers.Cases;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class CasesController : ControllerBase
{
    private readonly ICaseService _caseService;

    public CasesController(ICaseService caseService) => _caseService = caseService;

    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await _caseService.GetAllCasesAsync());

    [HttpGet("urgent")]
    public async Task<IActionResult> GetUrgent() => Ok(await _caseService.GetUrgentCasesForHomeAsync());

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var item = await _caseService.GetCaseDetailsAsync(id);
        if (item == null || item.Id == 0)
        {
            return NotFound(new { message = "الحالة غير موجودة" });
        }

        return Ok(item);
    }
}




