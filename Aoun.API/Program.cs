using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.EntityFrameworkCore;
using System.Text;
using Aoun.API.Middleware;
using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Aoun.BLL.Extensions;
using Aoun.BLL.DTOs.ChatAI;
using Aoun.BLL.DTOs.Zakat;
using Aoun.BLL.Interfaces.Admin;
using Aoun.BLL.Interfaces.Auth;
using Aoun.BLL.Interfaces.Profile;
using Aoun.BLL.Interfaces;
using Aoun.BLL.Services.Admin;
using Aoun.BLL.Services.Charity;
using Aoun.BLL.Services.Profile;
using Aoun.DAL.Repositories.UnitOfWork;

var builder = WebApplication.CreateBuilder(args);

builder.Configuration.AddEnvironmentVariables();

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")
        ?? "Server=.;Database='Aoun Charity Platform';Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=True"));

builder.Services.AddIdentity<ApplicationUser, IdentityRole>(options =>
{
    options.User.RequireUniqueEmail = true;
    options.SignIn.RequireConfirmedEmail = false;
    options.Password.RequiredLength = 8;
    options.Password.RequireDigit = true;
    options.Password.RequireLowercase = true;
    options.Password.RequireUppercase = true;
    options.Password.RequireNonAlphanumeric = true;
})
.AddEntityFrameworkStores<ApplicationDbContext>()
.AddDefaultTokenProviders();

var jwtSecret = builder.Configuration["JwtSettings:Secret"];
if (string.IsNullOrWhiteSpace(jwtSecret))
{
    throw new InvalidOperationException("JwtSettings:Secret is missing. Run the fix script or set user-secrets/environment variables.");
}

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["JwtSettings:Issuer"] ?? "AounApi",
        ValidAudience = builder.Configuration["JwtSettings:Audience"] ?? "AounAppUsers",
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSecret))
    };
});

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("AdminOnly", policy => policy.RequireRole(nameof(UserType.Admin)));
});

builder.Services.AddBllServices(builder.Configuration);
builder.Services.AddHttpClient<AISmartService>();
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
builder.Services.AddScoped<IAdminService, RealAdminService>();
builder.Services.AddScoped<ICharityService, RealCharityService>();
builder.Services.AddScoped<IProfileService, RealProfileService>();
builder.Services.AddScoped<ZakatService>();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        p => p.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod());
});

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseMiddleware<ExceptionMiddleware>();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseCors("AllowAll");
app.UseAuthorization();

using (var scope = app.Services.CreateScope())
{
    try
    {
        var db = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
        var userManager = scope.ServiceProvider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>();

await Aoun.API.Data.DbInitializer.SeedAsync(db, userManager, roleManager);
    }
    catch (Exception ex)
    {
        var logger = scope.ServiceProvider.GetRequiredService<ILoggerFactory>().CreateLogger("DbSeeder");
        logger.LogError(ex, "Database seeding failed");
        throw;
    }
}

app.MapControllers();

app.UseDeveloperExceptionPage();
app.Run();

public partial class Program { }



