namespace Aoun.BLL.DTOs.Cases;

public class UpdateCaseDto
{
    public string Title { get; set; } = "";
    public string Description { get; set; } = "";
    public decimal RequiredAmount { get; set; }
}