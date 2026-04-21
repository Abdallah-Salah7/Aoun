using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System.Net.Http.Json;
using System.Text.Json;
using Aoun.BLL.DTOs.ChatAI;

namespace Aoun.BLL.Services.Chat;

public class AISmartService
{
    private readonly HttpClient _httpClient;
    private readonly GeminiSettings _settings;
    private readonly ApplicationDbContext _db;

    public AISmartService(HttpClient httpClient, IOptions<GeminiSettings> settings, ApplicationDbContext db)
    {
        _httpClient = httpClient;
        _settings = settings.Value;
        _db = db;
    }

    public async Task<string> ChatWithAounAsync(string userMessage, string userName, string userRole)
    {
        var cases = await _db.Cases
            .AsNoTracking()
            .Where(c => !c.IsDeleted && c.Status != CaseStatus.Rejected)
            .OrderByDescending(c => c.Status == CaseStatus.Urgent)
            .ThenByDescending(c => c.Id)
            .Take(3)
            .ToListAsync();

        var casesContext = string.Join("\n", cases.Select(c => $"- {c.Title}: {c.Description}"));
        var identity = userRole == "Charity" ? "جمعية" : "متبرع";
        var fallback = $"أهلاً {userName} ({identity}).\n\nالحالات المقترحة:\n{casesContext}\n\nأرسل سؤالك وسأساعدك في التبرع أو اختيار الحالة الأنسب.";

        if (string.IsNullOrWhiteSpace(_settings.ApiKey))
        {
            return fallback;
        }

        var systemPrompt = $"أنت عون، مساعد ذكي. تخاطب {userName} وهو {identity}. الحالات المتاحة:\n{casesContext}";
        var url = $"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key={_settings.ApiKey}";
        var payload = new
        {
            contents = new[]
            {
                new
                {
                    parts = new[]
                    {
                        new { text = systemPrompt + "\n\nسؤال المستخدم: " + userMessage }
                    }
                }
            }
        };

        try
        {
            var response = await _httpClient.PostAsJsonAsync(url, payload);
            response.EnsureSuccessStatusCode();

            var json = await response.Content.ReadFromJsonAsync<JsonElement>();
            return json.GetProperty("candidates")[0].GetProperty("content").GetProperty("parts")[0].GetProperty("text").GetString() ?? fallback;
        }
        catch
        {
            return fallback;
        }
    }

    public async Task<string> GetRecommendedCasesAsync(string? userId = null)
    {
        if (string.IsNullOrWhiteSpace(userId))
        {
            var urgent = await _db.Cases.AsNoTracking()
                .Where(c => !c.IsDeleted && c.Status == CaseStatus.Urgent)
                .OrderByDescending(c => c.CollectedAmount / (c.RequiredAmount == 0 ? 1 : c.RequiredAmount))
                .Take(3)
                .Select(c => c.Title)
                .ToListAsync();

            return string.Join(", ", urgent);
        }

        var userDonations = await _db.Donations
            .AsNoTracking()
            .Include(d => d.Case)
            .Where(d => d.DonorId == userId && !d.IsDeleted && d.Case != null)
            .ToListAsync();

        if (!userDonations.Any())
        {
            var general = await _db.Cases.AsNoTracking()
                .Where(c => !c.IsDeleted)
                .OrderByDescending(c => c.Status == CaseStatus.Urgent)
                .Take(3)
                .Select(c => c.Title)
                .ToListAsync();

            return string.Join(", ", general);
        }

        var favoriteCategory = userDonations
            .GroupBy(d => d.Case!.Category)
            .OrderByDescending(g => g.Count())
            .Select(g => g.Key)
            .FirstOrDefault() ?? "General";

        var recommended = await _db.Cases.AsNoTracking()
            .Where(c => !c.IsDeleted && c.Category == favoriteCategory)
            .Take(3)
            .Select(c => c.Title)
            .ToListAsync();

        return string.Join(", ", recommended);
    }
}
