
namespace Aoun.BLL.DTOs.Cases;
public class CaseDto 
{ 
    public int Id { get; set; } 
    public string Title { get; set; } = ""; 
    public string Description { get; set; } = ""; 
    public decimal RequiredAmount { get; set; } 
    public decimal CollectedAmount { get; set; }
    public decimal RemainingAmount => RequiredAmount - CollectedAmount; // حساب تلقائي
    public string StatusName { get; set; } = "Active"; 
}




