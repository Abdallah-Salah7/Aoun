using Aoun.BLL.Services.Auth;

using Microsoft.Extensions.DependencyInjection;
using Aoun.BLL.DTOs.Auth;
using Aoun.BLL.DTOs.Cases;
using Aoun.BLL.DTOs.ChatAI;
using Aoun.BLL.DTOs.Zakat;
using Aoun.BLL.Interfaces;

namespace Aoun.API.Extensions;

public static class ServiceExtensions
{
    public static void AddApplicationServices(this IServiceCollection services)
    {
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<ICaseService, CaseService>(); // الربط الصحيح بين الـ Interface والـ Class
        services.AddScoped<AISmartService>();
        services.AddScoped<ZakatService>();
    }
}




