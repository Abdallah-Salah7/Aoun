
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Aoun.DAL.Entities;

namespace Aoun.DAL.Data;

public class ApplicationDbContext : IdentityDbContext<ApplicationUser> {
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

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

    protected override void OnModelCreating(ModelBuilder builder) {
        base.OnModelCreating(builder);

        builder.Entity<Case>().Property(c => c.RequiredAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Case>().Property(c => c.CollectedAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Donation>().Property(d => d.Amount).HasColumnType("decimal(18,2)");
        builder.Entity<Zakat>().Property(z => z.Amount).HasColumnType("decimal(18,2)");
        builder.Entity<DonorProfile>().Property(p => p.TotalDonated).HasColumnType("decimal(18,2)");
        builder.Entity<DonorProfile>().Property(p => p.TotalDonationsAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Campaign>().Property(c => c.TargetAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Campaign>().Property(c => c.CollectedAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Donation>().HasOne(d => d.Case).WithMany().HasForeignKey(d => d.CaseId).OnDelete(DeleteBehavior.Cascade); 
        builder.Entity<Donation>().HasOne(d => d.User).WithMany().HasForeignKey(d => d.UserId).OnDelete(DeleteBehavior.Restrict);
        // حل مشكلة الزكاة واليوزر (السبب الأساسي للـ Error)
        builder.Entity<Zakat>(entity => {
            entity.HasOne(d => d.Donor)
                  .WithMany(u => u.ZakatCalculations)
                  .HasForeignKey(d => d.DonorId) // ده الـ string
                  .OnDelete(DeleteBehavior.Cascade);

            entity.HasOne(d => d.DonorProfile)
                  .WithMany(p => p.Zakats)
                  .HasForeignKey(d => d.DonorProfileId) // ده الـ int
                  .OnDelete(DeleteBehavior.NoAction);
        });

        // إعدادات الـ Charity Profile واليوزر
        builder.Entity<CharityProfile>()
               .HasOne(c => c.User)
               .WithOne(u => u.CharityProfile)
               .HasForeignKey<CharityProfile>(c => c.UserId);

        // إعدادات الـ Donor Profile واليوزر
        builder.Entity<DonorProfile>()
               .HasOne(d => d.User)
               .WithOne(u => u.DonorProfile)
               .HasForeignKey<DonorProfile>(d => d.UserId);
               
        // منع الـ Multiple Cascade Paths في الـ Reports
        builder.Entity<Report>()
               .HasOne(r => r.Case)
               .WithMany(c => c.Reports)
               .OnDelete(DeleteBehavior.NoAction);
    }
}











