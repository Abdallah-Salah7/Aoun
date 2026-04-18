
using Aoun.DAL.Entities;
using Aoun.DAL.Repositories.Generic;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Aoun.DAL.Repositories.CaseRepo;

public interface ICaseRepository : IGenericRepository<Case> {
    // هنا بنكتب الدوال المخصصة لجدول الحالات فقط (مش موجودة في الجداول التانية)
    Task<IEnumerable<Case>> GetUrgentCasesAsync();
    Task<IEnumerable<Case>> GetCasesByCategoryAsync(string category);
}






