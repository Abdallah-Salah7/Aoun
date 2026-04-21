using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Aoun.BLL.DTOs.Auth;
using Aoun.BLL.DTOs.Cases;
using Aoun.BLL.DTOs.ChatAI;
using Aoun.BLL.Interfaces.Auth;
using Aoun.BLL.Interfaces.Cases;
using Aoun.BLL.Services.Chat;
namespace Aoun.BLL.Extensions;

public static class BllServiceExtensions
{
    public static IServiceCollection AddBllServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<GeminiSettings>(configuration.GetSection("GeminiSettings"));
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<ICaseService, CaseService>();
        services.AddScoped<Aoun.BLL.Services.Chat.AISmartService>();
        return services;
    }
}
