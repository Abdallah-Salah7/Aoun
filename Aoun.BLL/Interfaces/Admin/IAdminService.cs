
using Aoun.BLL.DTOs.Admin;
using System.Threading.Tasks;
using Aoun.BLL.DTOs.Cases;

namespace Aoun.BLL.Interfaces.Admin;
public interface IAdminService {
    Task<AdminDashboardStatsDto> GetStatsAsync();
    Task<object> GetAllCharitiesAsync();
    Task<object> GetCharityByIdAsync(int id);
    Task<bool> UpdateStatusAsync(int id, int status);
    Task<object> GetAllCasesAsync();
    Task<bool> DeleteCaseAsync(int id);
        Task<object> CreateCaseAsync(CreateCaseDto dto);
    Task<object> UpdateCaseAsync(int id, UpdateCaseDto dto);
    Task<object> GetTopDonorsAsync();
    Task<object> GetTopCharitiesAsync();
}




