namespace Aoun.DAL.Entities;
public class CharityProfile {
    public int Id { get; set; }
    public string CharityName { get; set; } = string.Empty;
    public string LicenseNumber { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public ProfileStatus Status { get; set; }
    public bool IsDeleted { get; set; } = false;
    public string UserId { get; set; } = string.Empty;
    public ApplicationUser? User { get; set; }
}







