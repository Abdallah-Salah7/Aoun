
using Aoun.BLL.DTOs.Cases;
namespace Aoun.BLL.Interfaces.Cases;

public interface ICaseService
{
    Task<List<CaseDto>> GetAllActiveCasesAsync();
    Task<List<CaseDto>> GetUrgentCasesForHomeAsync();
    Task<CaseDto> GetCaseDetailsAsync(int id);
    Task<List<CaseDto>> GetAllCasesAsync(); // مضافة للتوافق
}




