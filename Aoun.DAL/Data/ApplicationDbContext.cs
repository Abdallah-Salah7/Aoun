using Aoun.DAL.Entities;
using Aoun.DAL.Entities.Cases;
using Aoun.DAL.Entities.Category;
using Aoun.DAL.Entities.Charity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System.Reflection.Emit;

namespace Aoun.DAL.Data;

public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

    public DbSet<UserFavorite> UserFavorites { get; set; }
    public DbSet<DonorProfile> DonorProfiles { get; set; }
    public DbSet<CharityProfile> CharityProfiles { get; set; }
    public DbSet<Case> Cases { get; set; }
    public DbSet<Campaign> Campaigns { get; set; }
    public DbSet<Notification> Notifications { get; set; }
    public DbSet<Donation> Donations { get; set; }
    public DbSet<CharityDocument> CharityDocuments { get; set; }
    public DbSet<Zakat> ZakatCalculations { get; set; }
    public DbSet<TrustScore> TrustScores { get; set; }
    public DbSet<Report> Reports { get; set; }
    public DbSet<Category> Categories { get; set; }
    public DbSet<Charity> Charities { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<Favorite> Favorites { get; set; }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);
        // --- ULTIMATE PRODUCTION SEED START ---
        builder.Entity<Donation>().HasOne(d => d.Case).WithMany().HasForeignKey(d => d.CaseId).OnDelete(Microsoft.EntityFrameworkCore.DeleteBehavior.Restrict);
        builder.Entity<Donation>().HasOne(d => d.Campaign).WithMany().HasForeignKey(d => d.CampaignId).OnDelete(Microsoft.EntityFrameworkCore.DeleteBehavior.Restrict);
        builder.Entity<Donation>().HasOne(d => d.Charity).WithMany().HasForeignKey(d => d.CharityId).OnDelete(Microsoft.EntityFrameworkCore.DeleteBehavior.Restrict);

        builder.Entity<User>().HasData(new User { Id = 999, UserName = "AbdallahSalah", Email = "abdallah@aoun.com", Password = "SuperAdminPassword2026!", Role = "Admin" });
        builder.Entity<Charity>().HasData(new Charity { Id = 999, UserId = 999, Name = "Aoun Elite Charity", LicenseNumber = "A-100", Address = "Egypt", Description = "Main Production Charity" });
        builder.Entity<Category>().HasData(new Category { Id = 999, Name = "Medical Assistance", Description = "Urgent health cases", ImageUrl = "med.png" });
        // --- ULTIMATE PRODUCTION SEED END ---

        // Configuration for Decimals
        builder.Entity<Case>().Property(c => c.RequiredAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Case>().Property(c => c.CollectedAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Donation>().Property(d => d.Amount).HasColumnType("decimal(18,2)");
        builder.Entity<Zakat>().Property(z => z.Amount).HasColumnType("decimal(18,2)");
        builder.Entity<DonorProfile>().Property(p => p.TotalDonated).HasColumnType("decimal(18,2)");
        builder.Entity<DonorProfile>().Property(p => p.TotalDonationsAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Campaign>().Property(c => c.RequiredAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Campaign>().Property(c => c.CollectedAmount).HasColumnType("decimal(18,2)");

        // Relationships
        builder.Entity<Donation>().HasOne(d => d.Case).WithMany().HasForeignKey(d => d.CaseId).OnDelete(DeleteBehavior.Cascade);
        builder.Entity<Donation>().HasOne(d => d.User).WithMany().HasForeignKey(d => d.UserId).OnDelete(DeleteBehavior.Restrict);

        builder.Entity<Category>().HasData(
              new Category { Id = 1, Name = "الصحة", Description = "نعمل على توفير الرعاية الطبية والأدوية اللازمة والعمليات الجراحية العاجلة لمن هم في أمس الحاجة إليها، مساهمتك تنقذ حياة!", ImageUrl = "/images/categories/الصحه.png" },

              new Category { Id = 2, Name = "التعليم", Description = "نسعى لتوفير فرص تعليمية متكاملة للأطفال المحتاجين من كتب ومصاريف وأدوات دراسية، لأن التعليم حق لكل طفل!", ImageUrl = "/images/categories/التعليم.png" },

             new Category { Id = 3, Name = "الإغاثة", Description = "نمد يد العون للمتضررين من الكوارث والأزمات الإنسانية بتوفير المواد الغذائية والمستلزمات الضرورية العاجلة!", ImageUrl = "/images/categories/الاغاثة.png" },

            new Category { Id = 4, Name = "كفالات", Description = "اكفل يتيماً أو أسرة محتاجة وكن سبباً في توفير حياة كريمة لهم، مساهمتك الشهرية تصنع فرقاً حقيقياً في حياتهم!", ImageUrl = "/images/categories/كفالات.png" },

            new Category { Id = 5, Name = "مشاريع بناء", Description = "نعمل على بناء وتجديد المساكن للأسر الأكثر احتياجاً، لأن السكن الآمن أساس الحياة الكريمة!", ImageUrl = "/images/categories/مشاريع بناء.png" },

            new Category { Id = 6, Name = "التنمية", Description = "ندعم مشاريع التنمية المستدامة وتمكين الأسر اقتصادياً من خلال توفير فرص العمل والمشاريع الصغيرة!", ImageUrl = "/images/categories/التنميه.png" },

           new Category { Id = 7, Name = "ذوى الاحتياجات", Description = "نوفر الرعاية الشاملة والدعم اللازم لذوي الاحتياجات الخاصة من أجهزة وعلاج وتأهيل لحياة أفضل!", ImageUrl = "/images/categories/ذوى الاحتياجات.png" },

             new Category { Id = 8, Name = "كفارات", Description = "أد كفارتك بيسر وسهولة وكن على يقين أنها ستصل لمستحقيها بكل أمانة وشفافية!", ImageUrl = "/images/categories/كفارات.png" },

            new Category { Id = 9, Name = "الغارمين", Description = "نسعى لمساعدة الغارمين على سداد ديونهم وتخليصهم من أعباء الديون لبداية حياة جديدة كريمة!", ImageUrl = "/images/categories/الغارمين.png" },

            new Category { Id = 10, Name = "الاطعام", Description = "نعمل على توفير وجبات غذائية متكاملة للأسر المحتاجة والأيتام، لأن إطعام الجائع من أعظم الصدقات!", ImageUrl = "/images/categories/الاطعام.png" }
        );

       builder.Entity<Zakat>(entity => {
            entity.HasOne(d => d.Donor).WithMany(u => u.ZakatCalculations).HasForeignKey(d => d.DonorId).OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(d => d.DonorProfile).WithMany(p => p.Zakats).HasForeignKey(d => d.DonorProfileId).OnDelete(DeleteBehavior.NoAction);
        });

        builder.Entity<CharityProfile>().HasOne(c => c.User).WithOne(u => u.CharityProfile).HasForeignKey<CharityProfile>(c => c.UserId);
        builder.Entity<DonorProfile>().HasOne(d => d.User).WithOne(u => u.DonorProfile).HasForeignKey<DonorProfile>(d => d.UserId);
        builder.Entity<Report>().HasOne(r => r.Case).WithMany(c => c.Reports).OnDelete(DeleteBehavior.NoAction);

        // Favorites Unique Index
        builder.Entity<UserFavorite>().HasIndex(f => new { f.UserId, f.CaseId }).IsUnique();
    }
}






