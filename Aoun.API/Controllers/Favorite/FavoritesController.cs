using Microsoft.AspNetCore.Mvc;
using Aoun.BLL.DTOs.Favorite;
using Aoun.BLL.Interfaces.Favorite;

namespace Aoun.API.Controllers.Favorite
{
[Route("api/[controller]")]
[ApiController]
public class FavoritesController : ControllerBase
{
    private readonly IFavoritesService _service;

    public FavoritesController(IFavoritesService service)
    {
        _service = service;
    }

    [HttpPost("campaign/{id}")]
    public async Task<IActionResult> AddCampaign(int id, [FromQuery] int userId)
        => Ok(await _service.AddCampaign(id, userId));

    [HttpGet("campaigns")]
    public async Task<IActionResult> GetCampaigns([FromQuery] int userId)
        => Ok(await _service.GetFavoriteCampaigns(userId));

    [HttpDelete("campaign/{id}")]
    public async Task<IActionResult> RemoveCampaign(int id, [FromQuery] int userId)
        => Ok(await _service.RemoveCampaign(id, userId));

    [HttpPost("case/{id}")]
    public async Task<IActionResult> AddCase(int id, [FromQuery] int userId)
        => Ok(await _service.AddCase(id, userId));

    [HttpGet("cases")]
    public async Task<IActionResult> GetCases([FromQuery] int userId)
        => Ok(await _service.GetFavoriteCases(userId));

    [HttpDelete("case/{id}")]
    public async Task<IActionResult> RemoveCase(int id, [FromQuery] int userId)
        => Ok(await _service.RemoveCase(id, userId));
}
}