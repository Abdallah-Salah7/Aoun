using Microsoft.AspNetCore.Identity;
using Aoun.DAL.Entities;
using Aoun.DAL.Data;
using Microsoft.EntityFrameworkCore;

namespace Aoun.API.Data;

public static class DbInitializer
{
    public static async Task SeedAsync(
        ApplicationDbContext context,
        UserManager<ApplicationUser> userManager,
        RoleManager<IdentityRole> roleManager)
    {
        string[] roles = { "Admin", "Donor", "Charity" };
        foreach (var role in roles)
        {
            if (!await roleManager.RoleExistsAsync(role))
                await roleManager.CreateAsync(new IdentityRole(role));
        }

        var adminEmail = "admin@test.com";
        var adminUser = await userManager.FindByEmailAsync(adminEmail);

        if (adminUser != null)
        {
            await userManager.DeleteAsync(adminUser);
        }

        adminUser = new ApplicationUser
        {
            Email = adminEmail,
            UserName = adminEmail,
            FirstName = "System",
            UserType = UserType.Admin,
            EmailConfirmed = true
        };

        var createResult = await userManager.CreateAsync(adminUser, "Admin123!");
        if (createResult.Succeeded)
        {
            await userManager.AddToRoleAsync(adminUser, "Admin");
        }

        if (!await context.Cases.AnyAsync())
        {
            context.Cases.Add(new Case
            {
                Title = "توفير أجهزة طبية",
                Description = "مساعدة المحتاجين لتوفير أجهزة تنفس",
                RequiredAmount = 10000,
                CollectedAmount = 0,
                Status = CaseStatus.Active,
                Category = "Health",
                CharityProfileId = 1
            });
            await context.SaveChangesAsync();
        }
    }
}