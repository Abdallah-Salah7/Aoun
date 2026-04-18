using Aoun.BLL.DTOs.Profile;
using Aoun.BLL.Interfaces.Profile;
using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Aoun.BLL.Services.Profile;

public class RealProfileService : IProfileService
{
    private readonly ApplicationDbContext _db;
    private readonly UserManager<ApplicationUser> _userManager;

    public RealProfileService(ApplicationDbContext db, UserManager<ApplicationUser> userManager)
    {
        _db = db;
        _userManager = userManager;
    }

    public async Task<bool> UpdateProfileAsync(string userId, UpdateProfileDto model)
    {
        var user = await _userManager.FindByIdAsync(userId);
        if (user == null)
        {
            return false;
        }

        user.FirstName = model.FullName?.Trim() ?? user.FirstName;
        if (!string.IsNullOrWhiteSpace(model.PhoneNumber))
        {
            user.PhoneNumber = model.PhoneNumber.Trim();
        }

        if (!string.IsNullOrWhiteSpace(model.Email) && !string.Equals(user.Email, model.Email.Trim(), StringComparison.OrdinalIgnoreCase))
        {
            var newEmail = model.Email.Trim();
            var emailResult = await _userManager.SetEmailAsync(user, newEmail);
            if (!emailResult.Succeeded)
            {
                return false;
            }

            var userNameResult = await _userManager.SetUserNameAsync(user, newEmail);
            if (!userNameResult.Succeeded)
            {
                return false;
            }
        }

        var updateResult = await _userManager.UpdateAsync(user);
        return updateResult.Succeeded;
    }

    public async Task<bool> ChangePasswordAsync(string userId, ChangePasswordDto model)
    {
        var user = await _userManager.FindByIdAsync(userId);
        if (user == null)
        {
            return false;
        }

        var result = await _userManager.ChangePasswordAsync(user, model.CurrentPassword, model.NewPassword);
        return result.Succeeded;
    }

    public Task<bool> UploadPictureAsync(string userId, string url) => Task.FromResult(true);

    public async Task<object> GetActivityAsync(string userId)
    {
        var donations = await _db.Donations
            .AsNoTracking()
            .Where(d => d.DonorId == userId && !d.IsDeleted)
            .Include(d => d.Case)
            .Select(d => new
            {
                d.Amount,
                d.DonationDate,
                CaseTitle = d.Case != null ? d.Case.Title : string.Empty
            })
            .ToListAsync();

        return new
        {
            TotalDonations = donations.Count,
            History = donations
        };
    }
}
