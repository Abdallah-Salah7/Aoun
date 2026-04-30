using System;
using System.Collections.Generic;
using Aoun.DAL.Entities;
using CharityEntity = Aoun.DAL.Entities.Charity.Charity;

namespace Aoun.DAL.Entities
{
    public class Campaign
    {
        public int Id { get; set; }

        public string Title { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; }

        public decimal RequiredAmount { get; set; }
        public decimal CollectedAmount { get; set; }

        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

        public bool IsCompleted { get; set; }

        public DateTime CreatedAt { get; set; }
        public DateTime? CompletedAt { get; set; }              //انا ال ضفتها عشان اعرف امتى الحملة انتهت مش بس اعرف انها انتهت

        // FK
        public int CharityId { get; set; }
        public CharityEntity Charity { get; set; }

        public List<Donation> Donations { get; set; }
    }
}
