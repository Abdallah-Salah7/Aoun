using System;

namespace Aoun.DAL.Entities.User
{
    public class UserFavorite
    {
        public int Id { get; set; }
        public string UserId { get; set; } = string.Empty;
        public int CaseId { get; set; }
        public DateTime AddedAt { get; set; } = DateTime.UtcNow;

        public ApplicationUser? User { get; set; }
        public Case? Case { get; set; }
    }
}