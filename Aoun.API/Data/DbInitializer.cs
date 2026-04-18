using Microsoft.AspNetCore.Identity;
using Aoun.DAL.Entities;
using Aoun.DAL.Data;

namespace Aoun.API.Data;

public static class DbInitializer
{
    public static async Task SeedAsync(
        ApplicationDbContext context,
        UserManager<ApplicationUser> userManager,
        RoleManager<IdentityRole> roleManager)
    {
        // Roles
        if (!await roleManager.RoleExistsAsync("Admin"))
            await roleManager.CreateAsync(new IdentityRole("Admin"));

        if (!await roleManager.RoleExistsAsync("Donor"))
            await roleManager.CreateAsync(new IdentityRole("Donor"));

        // ❗ احذف القديم
        var old = await userManager.FindByEmailAsync("admin@test.com");
        if (old != null)
            await userManager.DeleteAsync(old);

        // ✅ Create Admin fresh
        var user = new ApplicationUser
        {
            Email = "admin@test.com",
            UserName = "admin@test.com",
            EmailConfirmed = true
        };

        await userManager.CreateAsync(user, "Aa123456!");
        await userManager.AddToRoleAsync(user, "Admin");
    }
}
