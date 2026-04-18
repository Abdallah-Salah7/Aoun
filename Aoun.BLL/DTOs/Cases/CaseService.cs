using Aoun.BLL.Interfaces.Cases;
using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Microsoft.EntityFrameworkCore;

namespace Aoun.BLL.DTOs.Cases;

public class CaseService : ICaseService
{
    private readonly ApplicationDbContext _db;

    public CaseService(ApplicationDbContext db)
    {
        _db = db;
    }

    public async Task<List<CaseDto>> GetAllActiveCasesAsync()
    {
        return await _db.Cases
            .AsNoTracking()
            .Where(c => !c.IsDeleted && c.CollectedAmount < c.RequiredAmount)
            .OrderByDescending(c => c.Status == CaseStatus.Urgent)
            .ThenBy(c => c.Id)
            .Select(c => new CaseDto
            {
                Id = c.Id,
                Title = c.Title,
                Description = c.Description,
                RequiredAmount = c.RequiredAmount,
                CollectedAmount = c.CollectedAmount,
                StatusName = c.Status.ToString()
            })
            .ToListAsync();
    }

    public async Task<List<CaseDto>> GetUrgentCasesForHomeAsync()
    {
        return await _db.Cases
            .AsNoTracking()
            .Where(c => !c.IsDeleted)
            .OrderByDescending(c => c.Status == CaseStatus.Urgent)
            .ThenBy(c => c.CollectedAmount < c.RequiredAmount ? 0 : 1)
            .ThenByDescending(c => c.Id)
            .Take(5)
            .Select(c => new CaseDto
            {
                Id = c.Id,
                Title = c.Title,
                Description = c.Description,
                RequiredAmount = c.RequiredAmount,
                CollectedAmount = c.CollectedAmount,
                StatusName = c.Status.ToString()
            })
            .ToListAsync();
    }

    public async Task<CaseDto> GetCaseDetailsAsync(int id)
    {
        var c = await _db.Cases.AsNoTracking().FirstOrDefaultAsync(x => x.Id == id && !x.IsDeleted);
        if (c == null)
        {
            return new CaseDto();
        }

        return new CaseDto
        {
            Id = c.Id,
            Title = c.Title,
            Description = c.Description,
            RequiredAmount = c.RequiredAmount,
            CollectedAmount = c.CollectedAmount,
            StatusName = c.Status.ToString()
        };
    }

    public async Task<List<CaseDto>> GetAllCasesAsync() => await GetAllActiveCasesAsync();
}
