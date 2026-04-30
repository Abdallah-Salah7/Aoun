using Aoun.DAL.Entities;
using DonationEntity = Aoun.DAL.Entities.Donation;
using CharityEntity = Aoun.DAL.Entities.Charity.Charity;
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

        //Task<Case?> GetCaseById(int id);
        //Task<Campaign?> GetCampaignById(int id);
        //Task<Charity?> GetCharityById(int id);

        Task<User?> GetUserByIdAsync(int id);
        Task<CaseEntity?> GetCaseByIdAsync(int id);
        Task<Campaign?> GetCampaignByIdAsync(int id);
        Task<CharityEntity?> GetCharityByIdAsync(int id);
    }
}