using Aoun.BLL.DTOs.Auth;
using Aoun.BLL.Interfaces.Auth;
using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Microsoft.EntityFrameworkCore;

namespace Aoun.BLL.Services.Charity;

public class RealCharityService : ICharityService
{
    private readonly ApplicationDbContext _db;

    public RealCharityService(ApplicationDbContext db)
    {
        _db = db;
    }

    public async Task<bool> CompleteProfileAsync(CharityRegistrationDto model, string userId)
    {
        if (string.IsNullOrWhiteSpace(userId))
        {
            return false;
        }

        var profile = await _db.CharityProfiles.FirstOrDefaultAsync(c => c.UserId == userId && !c.IsDeleted);
        if (profile == null)
        {
            profile = new CharityProfile
            {
                UserId = userId,
                CharityName = model.CharityName.Trim(),
                LicenseNumber = model.LicenseNumber.Trim(),
                Address = "Updated via API",
                Status = ProfileStatus.Pending
            };
            _db.CharityProfiles.Add(profile);
        }
        else
        {
            profile.CharityName = model.CharityName.Trim();
            profile.LicenseNumber = model.LicenseNumber.Trim();
            profile.Status = ProfileStatus.Pending;
        }

        await _db.SaveChangesAsync();
        return true;
    }

    public async Task<bool> UploadDocumentAsync(int charityId, string docUrl)
    {
        if (charityId <= 0 || string.IsNullOrWhiteSpace(docUrl))
        {
            return false;
        }

        var charity = await _db.CharityProfiles.FirstOrDefaultAsync(c => c.Id == charityId && !c.IsDeleted);
        if (charity == null)
        {
            return false;
        }

        _db.CharityDocuments.Add(new CharityDocument
        {
            CharityProfileId = charityId,
            DocumentName = "وثيقة جديدة",
            DocumentUrl = docUrl.Trim()
        });

        charity.Status = ProfileStatus.Pending;
        await _db.SaveChangesAsync();
        return true;
    }
}
