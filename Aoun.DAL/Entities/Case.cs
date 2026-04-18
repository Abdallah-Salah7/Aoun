
using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;

namespace Aoun.DAL.Entities;

public class Case
{
    public int Id { get; set; }
    [Required] public string Title { get; set; } = "";
    [Required] public string Description { get; set; } = "";
    public decimal RequiredAmount { get; set; } 
    public decimal CollectedAmount { get; set; }
    public CaseStatus Status { get; set; } = CaseStatus.Active;
    public string Category { get; set; } = "General";
    public bool IsDeleted { get; set; } = false;
    
    // 👇 الحقول اللي الـ DbInitializer بيعتمد عليها لربط الحالة بالجمعية
    public int CharityProfileId { get; set; }
    public virtual CharityProfile? CharityProfile { get; set; }

    public virtual ICollection<Report> Reports { get; set; } = new List<Report>();
}









