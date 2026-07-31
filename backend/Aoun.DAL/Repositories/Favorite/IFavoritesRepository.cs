using Aoun.DAL.Entities;
using FavoriteEntity = Aoun.DAL.Entities.Favorite;

namespace Aoun.DAL.Repositories.Favorite
{
    public interface IFavoritesRepository
    {
        IQueryable<FavoriteEntity> Query();

        Task<bool> CampaignExists(int id);
        Task<bool> CaseExists(int id);

        Task AddAsync(FavoriteEntity favorite);
        void Remove(FavoriteEntity favorite);

        Task<FavoriteEntity?> GetCampaignFavorite(int userId, int campaignId);
        Task<FavoriteEntity?> GetCaseFavorite(int userId, int caseId);

        Task SaveAsync();
    }
}