using Aoun.BLL.DTOs.Donations;
using Aoun.BLL.DTOs.Payment;

namespace Aoun.BLL.Interfaces.Donation
{
    public interface IDonationService
    {
        Task<object> CreateDonation(DonationCreateDto dto);
        Task<object> Pay(PaymentDto dto);

        Task<object> GetCaseDonations(int caseId, int page, int pageSize);
        Task<object> GetCampaignDonations(int campaignId, int page, int pageSize);
    }
}