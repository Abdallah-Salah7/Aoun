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

        //if (adminUser != null)
        //{
        //    await userManager.DeleteAsync(adminUser);
        //}
        if (!await context.Cases.AnyAsync())
        {
            var sampleCases = new List<Case>
    {
        new Case {
            Title = "إجراء عملية قلب مفتوح لطفل",
            Description = "الطفل سيف يحتاج لعملية قلب عاجلة في مركز أسوان للقلب، الحالة حرجة جداً.",
            RequiredAmount = 50000, CollectedAmount = 15000,
            IsCompleted = false, IsUrgent = false,
            CategoryId = 1, CharityId = 1, CreatedAt = DateTime.UtcNow
        },
        new Case {
            Title = "تجهيز 50 شنطة مدرسية",
            Description = "توفير المستلزمات الدراسية للأيتام في قرى صعيد مصر قبل بدء العام الدراسي.",
            RequiredAmount = 5000, CollectedAmount = 4800,
            IsCompleted = false, IsUrgent = false,
            CategoryId = 2, CharityId = 1, CreatedAt = DateTime.UtcNow
        },
        new Case {
            Title = "سداد ديون أرملة (غارمة)",
            Description = "السيدة مريم مهددة بالحبس بسبب ديون متبقية من تجهيز ابنتها اليتيمة.",
            RequiredAmount = 12000, CollectedAmount = 2000,
            IsCompleted = false, IsUrgent = false,
            CategoryId = 3, CharityId = 1, CreatedAt = DateTime.UtcNow
        },
        new Case {
            Title = "حفر بئر مياه في قرية نائية",
            Description = "توفير مياه شرب نظيفة لأكثر من 200 أسرة في منطقة تفتقر للمرافق الأساسية.",
            RequiredAmount = 30000, CollectedAmount = 0,
            IsCompleted = false, IsUrgent = false,
            CategoryId = 4, CharityId = 1, CreatedAt = DateTime.UtcNow
        },
        new Case {
            Title = "كفالة إطعام شهرية لـ 100 أسرة",
            Description = "توزيع كراتين المواد الغذائية الأساسية على الأسر الأكثر احتياجاً خلال شهر رمضان.",
            RequiredAmount = 20000, CollectedAmount = 18500,
            IsCompleted = false, IsUrgent = false,
            CategoryId = 5, CharityId = 1, CreatedAt = DateTime.UtcNow
        }
    };

            context.Cases.AddRange(sampleCases);
            await context.SaveChangesAsync();
        }
        if (!await context.CharityProfiles.AnyAsync())
        {
            context.CharityProfiles.AddRange(
                new CharityProfile
                {
                    CharityName = "جمعية الأورمان",
                    LicenseNumber = "123-ABC",
                    Status = ProfileStatus.Pending, 
                    UserId = "أي-Id-لمستخدم-عندك"
                },
                new CharityProfile
                {
                    CharityName = "مؤسسة مصر الخير",
                    LicenseNumber = "456-XYZ",
                    Status = ProfileStatus.Pending,
                    UserId = "أي-Id-تاني"
                }
            );
            await context.SaveChangesAsync();
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
                IsCompleted = false,
                IsUrgent = false,
                CategoryId = 1,
                CharityId = 1,
                CreatedAt = DateTime.UtcNow
            });
            await context.SaveChangesAsync();
        }
    }
}