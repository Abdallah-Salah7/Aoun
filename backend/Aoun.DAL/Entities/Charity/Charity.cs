using UserEntity = Aoun.DAL.Entities.User;
using Aoun.DAL.Entities;

namespace Aoun.DAL.Entities.Charity
{
    public class Charity
    {
        public int Id { get; set; }

        public int UserId { get; set; }   // 🔥 مهم جدا

        public string Name { get; set; }

        public string LicenseNumber { get; set; } // رقم الترخيص

        public string Address { get; set; }

        public string Description { get; set; }
        public decimal EmergencyFund { get; set; } // خزنة الطوارئ

        public bool IsApproved { get; set; } // علشان الأدمن

        public DateTime CreatedAt { get; set; }

        public UserEntity? User { get; set; }

        public List<Case>? Cases { get; set; }
        public List<Campaign>? Campaigns { get; set; }
    }
}