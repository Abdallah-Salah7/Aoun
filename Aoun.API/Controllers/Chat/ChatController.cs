using Aoun.BLL.DTOs.ChatAI;
using Aoun.BLL.DTOs.Auth;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;

namespace Aoun.API.Controllers;
[ApiController]
[Route("api/[controller]")]
[Authorize]
public class ChatController : ControllerBase
{
    private readonly AISmartService _aiService;
    public ChatController(AISmartService aiService) { _aiService = aiService; }
    [HttpPost("ask")]
    public async Task<IActionResult> AskAoun([FromBody] ChatRequest request)
    {
        var userName = User.FindFirstValue(ClaimTypes.Name) ?? "يا بطل";
        var userRole = User.FindFirstValue(ClaimTypes.Role) ?? "Donor";
        var response = await _aiService.ChatWithAounAsync(request.Message, userName, userRole);
        return Ok(new { reply = response });
    }
}







