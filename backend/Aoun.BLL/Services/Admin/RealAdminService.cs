using Aoun.BLL.DTOs.Admin;
using Aoun.BLL.DTOs.Case;
using Aoun.BLL.Interfaces.Admin;
using Aoun.BLL.Interfaces.Email; // تأكد من وجود هذا الـ using
using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Microsoft.EntityFrameworkCore;


namespace Aoun.BLL.Services.Admin;

public class RealAdminService : IAdminService
{
    private readonly ApplicationDbContext _db;
    private readonly IEmailService _emailService; 

    public RealAdminService(ApplicationDbContext db, IEmailService emailService)
    {
        _db = db;
        _emailService = emailService;
    }
    public async Task<object> GetAllCasesAsync()
    {
        return await _db.Cases
            .AsNoTracking()
            .Where(c => !c.IsDeleted)
            .ToListAsync();
    }
    public async Task<bool> DeleteCaseAsync(int id)
    {
        var entity = await _db.Cases.FirstOrDefaultAsync(c => c.Id == id && !c.IsDeleted);

        if (entity == null)
            return false;

        entity.IsDeleted = true;
        await _db.SaveChangesAsync();

        return true;
    }
    public async Task<AdminDashboardStatsDto> GetStatsAsync()
    {
        var cases = await _db.Cases.AsNoTracking().Where(c => !c.IsDeleted).ToListAsync();
        var totalDonations = await _db.Donations.AsNoTracking().Where(d => !d.IsDeleted).SumAsync(d => d.Amount);
        var charityCount = await _db.CharityProfiles.AsNoTracking().Where(c => !c.IsDeleted).CountAsync();
        var approvedCharities = await _db.CharityProfiles.AsNoTracking().Where(c => !c.IsDeleted && c.Status == ProfileStatus.Approved).CountAsync();

        var categoryStats = cases
            .GroupBy(c => c.Category.Name ?? "General")
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
        => await _db.CharityProfiles.AsNoTracking()
            .Include(c => c.User)
            .Where(c => !c.IsDeleted)
            .ToListAsync();

    public async Task<object?> GetCharityByIdAsync(int id)
        => await _db.CharityProfiles.AsNoTracking().Include(c => c.User).FirstOrDefaultAsync(c => c.Id == id && !c.IsDeleted);

    public async Task<bool> UpdateStatusAsync(int id, int status)
    {
        var charity = await _db.CharityProfiles.Include(c => c.User).FirstOrDefaultAsync(c => c.Id == id && !c.IsDeleted);

        if (charity != null && Enum.IsDefined(typeof(ProfileStatus), status))
        {
            charity.Status = (ProfileStatus)status;
            await _db.SaveChangesAsync();

            // إرسال الإيميل فقط في حالة القبول Approved
            if (charity.Status == ProfileStatus.Approved && charity.User?.Email != null)
            {
                await _emailService.SendEmailAsync(
                    charity.User.Email,
                    "AOUN | طلب الانضمام",
                    "مبروك! تم قبول جمعيتكم في منصة عون."
                );
            }
            return true;
        }

        // لو ملقاش جمعية، يدور في الحالات (Cases)
        var donationCase = await _db.Cases.FirstOrDefaultAsync(c => c.Id == id && !c.IsDeleted);
        if (donationCase != null && Enum.IsDefined(typeof(CaseStatus), status))
        {
            donationCase.Status = (CaseStatus)status;
            await _db.SaveChangesAsync();
            return true;
        }

        return false;
    }

    public async Task<object> CreateCaseAsync(CaseCreateDto dto)
    {
        var imagePath = dto.Image != null
            ? await ImageHelper.SaveImageAsync(dto.Image, "cases")
            : null;

        var entity = new Case
        {
            Title = dto.Title,
            Description = dto.Description,
            ImageUrl = imagePath,
            RequiredAmount = dto.RequiredAmount,
            CollectedAmount = 0,
            IsUrgent = dto.IsUrgent,
            CategoryId = dto.CategoryId,
            CharityId = dto.CharityId,
            CreatedAt = DateTime.UtcNow
        };

        await _db.Cases.AddAsync(entity);
        await _db.SaveChangesAsync();

        return entity;
    }

    public async Task<object> UpdateCaseAsync(int id, CaseUpdateDto dto)
    {
        var entity = await _db.Cases.FindAsync(id);
        if (entity == null) return new { message = "Case not found" };

        entity.Title = dto.Title;
        entity.Description = dto.Description;
        entity.RequiredAmount = dto.RequiredAmount;
        entity.IsUrgent = dto.IsUrgent;
        entity.CategoryId = dto.CategoryId;

        if (dto.Image != null)
        {
            entity.ImageUrl = await ImageHelper.SaveImageAsync(dto.Image, "cases");
        }

        await _db.SaveChangesAsync();
        return entity;
    }

    public async Task<object> GetTopDonorsAsync()
    {
        return await _db.Donations
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
                (d, u) => new { email = u.Email, total = d.Total }
            )
            .ToListAsync();
    }

    public async Task<object> GetTopCharitiesAsync()
    {
        return await _db.Cases
            .GroupBy(c => c.Title)
            .Select(g => new
            {
                name = g.Key,
                total = g.Sum(x => x.CollectedAmount)
            })
            .OrderByDescending(x => x.total)
            .Take(5)
            .ToListAsync();
    }
}