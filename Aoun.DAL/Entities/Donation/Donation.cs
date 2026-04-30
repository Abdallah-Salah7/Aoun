using Aoun.DAL.Entities;
using System.ComponentModel.DataAnnotations.Schema;
using CharityEntity = Aoun.DAL.Entities.Charity.Charity;


namespace Aoun.DAL.Entities
{
    public class Donation
    {
        public int Id { get; set; }

        public decimal Amount { get; set; }

        public int? UserId { get; set; }

        // Added DonorName to store donor display name
        public string DonorName { get; set; }


        public int CharityId { get; set; }

        public string DonationTargetType { get; set; }

        public int? CaseId { get; set; }

        [ForeignKey("CaseId")]
        public virtual Case? Case { get; set; }

        public int? CampaignId { get; set; }

        public bool IsGift { get; set; }

        public string? GiftReceiverName { get; set; }

        public string? GiftReceiverPhone { get; set; }

        public string? GiftMessage { get; set; }

        public string PaymentMethod { get; set; }

        public string PaymentStatus { get; set; }

        public DateTime CreatedAt { get; set; }

        public bool IsDeleted { get; set; } = false;

        public CharityEntity Charity { get; set; }
        public User User { get; set; }
        public int? CategoryId { get; set; }
        public Campaign? Campaign { get; set; }

    }
}