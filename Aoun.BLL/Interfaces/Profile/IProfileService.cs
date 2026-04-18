using Aoun.BLL.DTOs.Profile;
using System.Threading.Tasks;

namespace Aoun.BLL.Interfaces.Profile;
public interface IProfileService {
    Task<bool> UpdateProfileAsync(string userId, UpdateProfileDto model);
    Task<bool> ChangePasswordAsync(string userId, ChangePasswordDto model);
    Task<bool> UploadPictureAsync(string userId, string url);
    Task<object> GetActivityAsync(string userId);
}




