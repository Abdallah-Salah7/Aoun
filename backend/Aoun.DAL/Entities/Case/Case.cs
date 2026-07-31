using System;
using System.Collections.Generic;
using CategoryEntity = Aoun.DAL.Entities.Category.Category;
using CharityEntity = Aoun.DAL.Entities.Charity.Charity;
using DonationEntity = Aoun.DAL.Entities.Donation;
using ReportEntity = Aoun.DAL.Entities.Cases.Report;
namespace Aoun.DAL.Entities
{
    public class Case
    {
        public int Id { get; set; }

        public bool IsDeleted { get; set; } = false;

        public CaseStatus Status { get; set; }
        public string Title { get; set; }

        public string Description { get; set; }

        public string ImageUrl { get; set; }

        public decimal RequiredAmount { get; set; }

        public decimal CollectedAmount { get; set; }

        public bool IsUrgent { get; set; }

        public bool IsCompleted { get; set; }

        public int CategoryId { get; set; }

        public int CharityId { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateTime? CompletedAt { get; set; }

        public CategoryEntity? Category { get; set; }

        public CharityEntity? Charity { get; set; }

        public List<DonationEntity>? Donations { get; set; }

        // Navigation for reports
        public List<ReportEntity>? Reports { get; set; }
    }
}
