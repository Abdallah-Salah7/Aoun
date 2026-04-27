using Aoun.BLL.DTOs;

namespace Aoun.BLL.Interfaces.Favorite
{
public interface IFavoritesService
{
    Task<object> AddCampaign(int campaignId, int userId);
    Task<object> RemoveCampaign(int campaignId, int userId);
    Task<object> GetFavoriteCampaigns(int userId);

    Task<object> AddCase(int caseId, int userId);
    Task<object> RemoveCase(int caseId, int userId);
    Task<object> GetFavoriteCases(int userId);
}
}