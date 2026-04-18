using CaseStatus = Aoun.DAL.Entities.CaseStatus;

using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Aoun.DAL.Repositories.Generic;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Aoun.DAL.Repositories.CaseRepo;

public class CaseRepository : GenericRepository<Case>, ICaseRepository {
    private readonly ApplicationDbContext _context;
    
    public CaseRepository(ApplicationDbContext context) : base(context) {
        _context = context;
    }

    // تنفيذ الدوال المخصصة
    public async Task<IEnumerable<Case>> GetUrgentCasesAsync() {
        return await _context.Cases
            .Where(c => c.Status == CaseStatus.Urgent && !c.IsDeleted)
            .ToListAsync();
    }

    public async Task<IEnumerable<Case>> GetCasesByCategoryAsync(string category) {
        return await _context.Cases
            .Where(c => c.Category == category && !c.IsDeleted)
            .ToListAsync();
    }
}














