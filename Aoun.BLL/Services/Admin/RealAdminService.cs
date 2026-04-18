using Aoun.BLL.DTOs.Admin;
using Aoun.BLL.Interfaces.Admin;
using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Microsoft.EntityFrameworkCore;
using Aoun.BLL.DTOs.Cases;

namespace Aoun.BLL.Services.Admin;

public class RealAdminService : IAdminService
{
    private readonly ApplicationDbContext _db;
    public RealAdminService(ApplicationDbContext db) => _db = db;

    public async Task<AdminDashboardStatsDto> GetStatsAsync()
    {
        var cases = await _db.Cases.AsNoTracking().Where(c => !c.IsDeleted).ToListAsync();
        var totalDonations = await _db.Donations.AsNoTracking().Where(d => !d.IsDeleted).SumAsync(d => d.Amount);
        var charityCount = await _db.CharityProfiles.AsNoTracking().Where(c => !c.IsDeleted).CountAsync();
        var approvedCharities = await _db.CharityProfiles.AsNoTracking().Where(c => !c.IsDeleted && c.Status == ProfileStatus.Approved).CountAsync();
        var categoryStats = cases
            .GroupBy(c => c.Category ?? "General")
            .Select(g => new
            {
                Category = g.Key,
                Count = g.Count(),
                Percentage = cases.Count == 0 ? 0 : Math.Round((decimal)g.Count() * 100m / cases.Count, 2)
            })
            .ToList();

        return new AdminDashboardStatsDto
        {
            TotalDonors = await _db.Users.AsNoTracking().CountAsync(u => u.UserType == UserType.Donor),
            TotalCases = cases.Count,
            TotalDonationsAmount = totalDonations,
            CategoryPercentages = new
            {
                Categories = categoryStats,
                TotalCharities = charityCount,
                ApprovedCharities = approvedCharities
            }
        };
    }

    public async Task<object> GetAllCharitiesAsync()
        => await _db.CharityProfiles.AsNoTracking().Where(c => !c.IsDeleted).ToListAsync();

    public async Task<object> GetCharityByIdAsync(int id)
        => await _db.CharityProfiles.AsNoTracking().FirstOrDefaultAsync(c => c.Id == id && !c.IsDeleted)!;

    public async Task<bool> UpdateStatusAsync(int id, int status)
    {
        var charity = await _db.CharityProfiles.FirstOrDefaultAsync(c => c.Id == id && !c.IsDeleted);
        if (charity != null && Enum.IsDefined(typeof(ProfileStatus), status))
        {
            charity.Status = (ProfileStatus)status;
            await _db.SaveChangesAsync();
            return true;
        }

        var donationCase = await _db.Cases.FirstOrDefaultAsync(c => c.Id == id && !c.IsDeleted);
        if (donationCase != null && Enum.IsDefined(typeof(CaseStatus), status))
        {
            donationCase.Status = (CaseStatus)status;
            await _db.SaveChangesAsync();
            return true;
        }

        return false;
    }
    public async Task<object> CreateCaseAsync(CreateCaseDto dto)
{
    var entity = new Case
    {
        Title = dto.Title,
        Description = dto.Description,
        RequiredAmount = dto.RequiredAmount,
        CollectedAmount = 0
    };

    await _db.Cases.AddAsync(entity);
    await _db.SaveChangesAsync();

    return entity;
}
public async Task<object> UpdateCaseAsync(int id, UpdateCaseDto dto)
{
    var c = await _db.Cases.FindAsync(id);

    if (c == null)
        return new { message = "Case not found" };

    c.Title = dto.Title;
    c.Description = dto.Description;
    c.RequiredAmount = dto.RequiredAmount;

    await _db.SaveChangesAsync();

    return c;
}


    public async Task<object> GetAllCasesAsync()
        => await _db.Cases.AsNoTracking().Where(c => !c.IsDeleted).ToListAsync();

    public async Task<bool> DeleteCaseAsync(int id)
    {
        var c = await _db.Cases.FirstOrDefaultAsync(x => x.Id == id && !x.IsDeleted);
        if (c == null)
        {
            return false;
        }

        c.IsDeleted = true;
        await _db.SaveChangesAsync();
        return true;
    }
public async Task<object> GetTopDonorsAsync()
{
    var data = await _db.Donations
        .Where(d => d.UserId != null)
        .GroupBy(d => d.UserId)
        .Select(g => new
        {
            UserId = g.Key,
            Total = g.Sum(x => x.Amount)
        })
        .OrderByDescending(x => x.Total)
        .Take(5)
        .Join(
            _db.Users,
            d => d.UserId,
            u => u.Id,
            (d, u) => new
            {
                email = u.Email,
                total = d.Total
            }
        )
        .ToListAsync();

    return data; 
}
public async Task<object> GetTopCharitiesAsync()
{
    var data = await _db.Cases
        .GroupBy(c => c.Title)
        .Select(g => new
        {
            name = g.Key,
            total = g.Sum(x => x.CollectedAmount)
        })
        .OrderByDescending(x => x.total)
        .Take(5)
        .ToListAsync();

    return data;
}
}
