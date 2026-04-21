using Aoun.API.Middleware;
using Aoun.BLL.DTOs.ChatAI;
using Aoun.BLL.DTOs.Zakat;
using Aoun.BLL.Extensions;
using Aoun.BLL.Interfaces;
using Aoun.BLL.Interfaces.Admin;
using Aoun.BLL.Interfaces.Auth;
using Aoun.BLL.Interfaces.Profile;
using Aoun.BLL.Services.Admin;
using Aoun.BLL.Services.Charity;
using Aoun.BLL.Services.Chat;
using Aoun.BLL.Services.Profile;
using Aoun.BLL.Services.Zakat;
using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Aoun.DAL.Repositories.UnitOfWork;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Security.Claims;
using System.Text;



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
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["JwtSettings:Secret"])),

        RoleClaimType = ClaimTypes.Role
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
builder.Services.AddHttpClient<MetalPriceService>();
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddMemoryCache();
builder.Services.AddScoped<StripeService>();
Stripe.StripeConfiguration.ApiKey = builder.Configuration["Stripe:SecretKey"];
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("AdminOnly", policy => policy.RequireRole("Admin"));
});

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        p => p.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod());
});
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo { Title = "Aoun API", Version = "v1" });

    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Please enter 'Bearer' followed by a space and then your token.\n\nExample: Bearer eyJhbGciOi..."
    });

    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

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


using (var scope = app.Services.CreateScope())
{
var scopedProvider = scope.ServiceProvider; // تعريف الـ Provider هنا
try
{
var context = scopedProvider.GetRequiredService<ApplicationDbContext>();
var userManager = scopedProvider.GetRequiredService<UserManager<ApplicationUser>>();
var roleManager = scopedProvider.GetRequiredService<RoleManager<IdentityRole>>();

await Aoun.API.Data.DbInitializer.SeedAsync(context, userManager, roleManager);
}
catch (Exception ex)
{
var logger = scopedProvider.GetRequiredService<ILogger<Program>>();
logger.LogError(ex, "Error while Database Seeding");
}
}

app.MapControllers();
app.Run();

public partial class Program { }

