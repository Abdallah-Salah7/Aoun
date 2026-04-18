using Microsoft.AspNetCore.Authorization;
using Aoun.BLL.DTOs.Profile;
using Aoun.BLL.DTOs.Cases;
using Aoun.BLL.DTOs.Auth;
using Aoun.DAL.Repositories.UnitOfWork;
using Microsoft.AspNetCore.Mvc;
using Aoun.DAL.Repositories;
using Aoun.DAL.Entities;
using Microsoft.EntityFrameworkCore;

namespace Aoun.API.Controllers.Home;

[Route("api/[controller]")]
[ApiController]

public class HomeController : ControllerBase
{
    private readonly IUnitOfWork _uow;

    public HomeController(IUnitOfWork uow) => _uow = uow;

    [HttpGet]
    public async Task<IActionResult> GetHomeData()
    {
        var categories = new[] { "الأيتام", "الصحة", "الإغاثة", "التعليم" };
        var cases = await _uow.Repository<Case>().GetAllAsync();
        var featuredCharities = await _uow.Repository<CharityProfile>().GetAllAsync();

        var trendingCases = cases.Where(c => !c.IsDeleted).OrderByDescending(c => c.Status == CaseStatus.Urgent).Take(5);
        var visibleCharities = featuredCharities.Where(c => !c.IsDeleted && c.Status == ProfileStatus.Approved).Take(3);

        return Ok(new
        {
            Categories = categories,
            TrendingCases = trendingCases,
            FeaturedCharities = visibleCharities
        });
    }
}




