using Aoun.BLL.DTOs;
using Aoun.BLL.DTOs.Donations;
using Aoun.BLL.DTOs.Payment;
using Aoun.BLL.Interfaces;
using Aoun.BLL.Interfaces.Donation;
using Aoun.DAL.Repositories.Donation;
using Microsoft.EntityFrameworkCore;

namespace Aoun.BLL.Services
{

    public class DonationService : IDonationService
    {
        private readonly IDonationRepository _repo;

        public DonationService(IDonationRepository repo)
        {
            _repo = repo;
        }

        // ================= CREATE =================
        public async Task<object> CreateDonation(DonationCreateDto dto)
        {
            if (dto.Amount <= 0)
                return new { message = "المبلغ لازم يكون أكبر من صفر" };

            if (dto.TargetType != "Case" &&
                dto.TargetType != "Campaign" &&
                dto.TargetType != "Charity")
                return new { message = "TargetType غير صحيح" };

            int charityId;

            // ================= CASE =================
            if (dto.TargetType == "Case")
            {
                var caseEntity = await _repo.GetCaseByIdAsync(dto.TargetId);

                if (caseEntity == null)
                    return new { message = "Case not found" };

                charityId = caseEntity.CharityId;
            }

            // ================= CAMPAIGN =================
            else if (dto.TargetType == "Campaign")
            {
                var campaign = await _repo.GetCampaignByIdAsync(dto.TargetId);

                if (campaign == null)
                    return new { message = "Campaign not found" };

                charityId = campaign.CharityId;
            }

            // ================= CHARITY =================
            else
            {
                var charity = await _repo.GetCharityByIdAsync(dto.TargetId);

                if (charity == null)
                    return new { message = "Charity not found" };

                charityId = dto.TargetId;
            }
            string donorName = "فاعل خير";
            if (dto.UserId.HasValue)   // ⭐ بدل dto.UserId != null
            {
                var user = await _repo.GetUserByIdAsync(dto.UserId.Value);

                if (user != null)
                    donorName = user.UserName;
            }

            /*

             */


            var donation = new Donation
            {
                Amount = dto.Amount,
                UserId = dto.UserId,
                DonorName = dto.DonorName,
                DonationTargetType = dto.TargetType,

                CaseId = dto.TargetType == "Case" ? dto.TargetId : null,
                CampaignId = dto.TargetType == "Campaign" ? dto.TargetId : null,

                CharityId = charityId,

                IsGift = dto.IsGift,
                GiftReceiverName = dto.GiftReceiverName,
                GiftReceiverPhone = dto.GiftReceiverPhone,
                GiftMessage = dto.GiftMessage,

                PaymentStatus = "Pending",
                PaymentMethod = "Pending",
                CreatedAt = DateTime.UtcNow
            };

            await _repo.AddAsync(donation);
            await _repo.SaveAsync();

            return new
            {
                donationId = donation.Id,
                message = "Donation created"
            };
        }

        // ================= PAY =================
        public async Task<object> Pay(PaymentDto dto)
        {
            var donation = await _repo.GetByIdAsync(dto.DonationId);

            if (donation == null)
                return new { message = "Donation not found" };

            if (donation.PaymentStatus == "Paid")
                return new { message = "Already paid" };

            if (donation.UserId != dto.UserId)
                return new { message = "Not allowed" };

            donation.PaymentStatus = "Paid";
            donation.PaymentMethod = dto.PaymentMethod;

            await UpdateTarget(donation);
            await CheckComplete(donation);

            await _repo.SaveAsync();

            return new { message = "Payment successful" };
        }

        // ================= GET CASE DONATIONS =================
        public async Task<object> GetCaseDonations(int caseId, int page, int pageSize)
        {
            //var query = _repo.Query()
            //    .Include(d => d.User)
            //    .Where(d => d.CaseId == caseId && d.PaymentStatus == "Paid");

            var query = _repo.Query()
        .Include(d => d.User)
        .Where(d => d.CaseId == caseId && d.PaymentStatus == "Paid");

            var total = await query.CountAsync();

            var data = await query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .Select(d => new DonationListItemDto
                {
                    Id = d.Id,
                    DonorName = d.User != null ? d.User.UserName : "فاعل خير",
                    Amount = d.Amount,
                    IsGift = d.IsGift,
                    Date = d.CreatedAt
                })
                .ToListAsync();

            return new { total, data };
        }

        // ================= GET CAMPAIGN DONATIONS =================
        public async Task<object> GetCampaignDonations(int campaignId, int page, int pageSize)
        {
            var query = _repo.Query()
                .Include(d => d.User)
                .Where(d => d.CampaignId == campaignId && d.PaymentStatus == "Paid");

            var total = await query.CountAsync();

            var data = await query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .Select(d => new DonationListItemDto
                {
                    Id = d.Id,
                    DonorName = d.User != null ? d.User.UserName : "فاعل خير",
                    Amount = d.Amount,
                    IsGift = d.IsGift,
                    Date = d.CreatedAt
                })
                .ToListAsync();

            return new { total, data };
        }

        // ================= HELPERS =================
        private async Task UpdateTarget(Donation donation)
        {
            if (donation.CaseId != null)
            {
                var c = await _repo.GetCaseByIdAsync(donation.CaseId.Value);
                if (c != null) c.CollectedAmount += donation.Amount;
            }
            else if (donation.CampaignId != null)
            {
                var camp = await _repo.GetCampaignByIdAsync(donation.CampaignId.Value);
                if (camp != null) camp.CollectedAmount += donation.Amount;
            }
            else
            {
                var charity = await _repo.GetCharityByIdAsync(donation.CharityId);
                if (charity != null) charity.EmergencyFund += donation.Amount;
            }
        }

        private async Task CheckComplete(Donation donation)
        {
            if (donation.CaseId != null)
            {
                var c = await _repo.GetCaseByIdAsync(donation.CaseId.Value);
                if (c != null && c.CollectedAmount >= c.RequiredAmount)
                    c.IsCompleted = true;
            }
            else if (donation.CampaignId != null)
            {
                var camp = await _repo.GetCampaignByIdAsync(donation.CampaignId.Value);
                if (camp != null && camp.CollectedAmount >= camp.RequiredAmount)
                    camp.IsCompleted = true;
            }
        }
    }
}