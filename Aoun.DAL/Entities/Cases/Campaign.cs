using System;
namespace Aoun.DAL.Entities;
public class Campaign {
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string ImageUrl { get; set; } = string.Empty;
    public decimal TargetAmount { get; set; }
    public decimal CollectedAmount { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public bool IsDeleted { get; set; } = false;
    public int CharityProfileId { get; set; }
    public CharityProfile? CharityProfile { get; set; }
}






