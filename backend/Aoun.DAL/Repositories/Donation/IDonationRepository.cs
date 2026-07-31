using Aoun.DAL.Entities;
using System.Linq;
using System.Threading.Tasks;
using DonationEntity = Aoun.DAL.Entities.Donation;
using CaseEntity = Aoun.DAL.Entities.Case;

namespace Aoun.DAL.Repositories.Donation
{
    public interface IDonationRepository
    {
        Task AddAsync(DonationEntity donation);
        Task<DonationEntity?> GetByIdAsync(int id);
        IQueryable<DonationEntity> Query();
        void Update(DonationEntity donation);
        Task SaveAsync();

        Task<User?> GetUserByIdAsync(int id);
        Task<CaseEntity?> GetCaseByIdAsync(int id);
        Task<Campaign?> GetCampaignByIdAsync(int id);

        // 🔥 تم تحديث النوع هنا ليتطابق مع الـ Repository
        Task<CharityProfile?> GetCharityByIdAsync(int id);
    }
}