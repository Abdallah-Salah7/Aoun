using Aoun.DAL.Entities;
using Aoun.DAL.Entities.User;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

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

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        // Configuration for Decimals
        builder.Entity<Case>().Property(c => c.RequiredAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Case>().Property(c => c.CollectedAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Donation>().Property(d => d.Amount).HasColumnType("decimal(18,2)");
        builder.Entity<Zakat>().Property(z => z.Amount).HasColumnType("decimal(18,2)");
        builder.Entity<DonorProfile>().Property(p => p.TotalDonated).HasColumnType("decimal(18,2)");
        builder.Entity<DonorProfile>().Property(p => p.TotalDonationsAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Campaign>().Property(c => c.TargetAmount).HasColumnType("decimal(18,2)");
        builder.Entity<Campaign>().Property(c => c.CollectedAmount).HasColumnType("decimal(18,2)");

        // Relationships
        builder.Entity<Donation>().HasOne(d => d.Case).WithMany().HasForeignKey(d => d.CaseId).OnDelete(DeleteBehavior.Cascade);
        builder.Entity<Donation>().HasOne(d => d.User).WithMany().HasForeignKey(d => d.UserId).OnDelete(DeleteBehavior.Restrict);

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