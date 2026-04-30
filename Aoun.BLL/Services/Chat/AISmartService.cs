using Microsoft.Extensions.Configuration;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text;
using System.Text.Json;

namespace Aoun.BLL.Services.Chat
{
    public class AISmartService
    {
        private readonly HttpClient _http;
        private readonly string _geminiKey;
        private readonly string _openAiKey;
        private readonly string _deepSeekKey;
        private readonly string _groqKey;

        public AISmartService(HttpClient http, IConfiguration config)
        {
            _http = http;

            // ⚠️ نصيحة أمنية: يفضل دايماً نقل المفاتيح دي لـ appsettings.json عشان متبقاش مكشوفة في الكود
            _geminiKey = "REDACTED_GEMINI_KEY";
            _openAiKey = "REDACTED_OPENAI_KEY";
            _deepSeekKey = "REDACTED_DEEPSEEK_KEY";
            _groqKey = "REDACTED_GROQ_KEY";
        }

        // =================================================================
        // 🚀 السحر الهندسي: استراتيجية التبديل التلقائي (Groq في المقدمة)
        // =================================================================
        private async Task<string> AskAIWithFallbackAsync(string systemPrompt, string userPrompt)
        {
            string fullPrompt = $"{systemPrompt}\n\n{userPrompt}";
            List<string> errors = new List<string>();

            // 1. المحاولة الأولى: Groq (أسرع ومجاني ومفتاحه شغال)
            if (!string.IsNullOrEmpty(_groqKey))
            {
                try
                {
                    Console.WriteLine("🤖 [Routing] Trying Groq (Llama 70B)...");
                    // غيرنا الموديل للنسخة الـ 70B العملاقة والذكية جداً في العربي
                    return await AskOpenAICompatibleAsync(_groqKey, "https://api.groq.com/openai/v1/chat/completions", "llama-3.3-70b-versatile", systemPrompt, userPrompt);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"⚠️ Groq Failed: {ex.Message}");
                    errors.Add($"Groq: {ex.Message}");
                }
            }

            // 2. المحاولة الثانية: Gemini
            if (!string.IsNullOrEmpty(_geminiKey))
            {
                try
                {
                    Console.WriteLine("🤖 [Routing] Trying Google Gemini...");
                    return await AskGeminiAsync(fullPrompt);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"⚠️ Gemini Failed: {ex.Message}");
                    errors.Add($"Gemini: {ex.Message}");
                }
            }

            // 3. المحاولة الثالثة: OpenAI (ChatGPT)
            if (!string.IsNullOrEmpty(_openAiKey))
            {
                try
                {
                    Console.WriteLine("🤖 [Routing] Trying OpenAI (ChatGPT)...");
                    return await AskOpenAICompatibleAsync(_openAiKey, "https://api.openai.com/v1/chat/completions", "gpt-4o-mini", systemPrompt, userPrompt);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"⚠️ OpenAI Failed: {ex.Message}");
                    errors.Add($"OpenAI: {ex.Message}");
                }
            }

            // 4. المحاولة الرابعة: DeepSeek
            if (!string.IsNullOrEmpty(_deepSeekKey))
            {
                try
                {
                    Console.WriteLine("🤖 [Routing] Trying DeepSeek...");
                    return await AskOpenAICompatibleAsync(_deepSeekKey, "https://api.deepseek.com/chat/completions", "deepseek-chat", systemPrompt, userPrompt);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"⚠️ DeepSeek Failed: {ex.Message}");
                    errors.Add($"DeepSeek: {ex.Message}");
                }
            }

            // لو الـ 4 وقعوا
            throw new Exception($"❌ All AI providers failed! Errors log: {string.Join(" | ", errors)}");
        }

        // =================================================================
        // 🌐 دوال الاتصال الخاصة بكل شركة
        // =================================================================

        private async Task<string> AskGeminiAsync(string prompt)
        {
            string requestUrl = $"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key={_geminiKey}";
            var requestBody = new { contents = new[] { new { parts = new[] { new { text = prompt } } } } };
            var request = new HttpRequestMessage(HttpMethod.Post, requestUrl)
            {
                Content = new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json")
            };

            var response = await _http.SendAsync(request);
            if (!response.IsSuccessStatusCode) throw new Exception(await response.Content.ReadAsStringAsync());

            var jsonResponse = await response.Content.ReadFromJsonAsync<JsonElement>();
            return jsonResponse.GetProperty("candidates")[0].GetProperty("content").GetProperty("parts")[0].GetProperty("text").GetString() ?? "";
        }

        private async Task<string> AskOpenAICompatibleAsync(string apiKey, string url, string modelName, string sysPrompt, string usrPrompt)
        {
            // تعليمات صارمة جداً تمنع الموديل من التصرف كآلة
            string strictSystemPrompt = sysPrompt + "\nتعليمات صارمة: لا تذكر أبداً أنك ذكاء اصطناعي أو روبوت أو نموذج لغوي. لا تستخدم مقدمات مثل 'بصفتي كذا' أو 'إليك الإجابة'. تحدث كإنسان طبيعي، ودود، ومباشر يعمل في فريق الدعم. استخدم صيغة المخاطب مع المستخدم (أنت، لك، يا فاعل الخير).";

            var requestBody = new
            {
                model = modelName,
                messages = new[] {
            new { role = "system", content = strictSystemPrompt },
            new { role = "user", content = usrPrompt }
        },
                temperature = 0.3, // نسبة ممتازة للردود المنطقية الإنسانية
                max_tokens = 500   // مناسب جداً عشان ميضربش Rate Limit من Groq
            };

            var request = new HttpRequestMessage(HttpMethod.Post, url);
            request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", apiKey);
            request.Content = new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json");

            var response = await _http.SendAsync(request);
            if (!response.IsSuccessStatusCode) throw new Exception(await response.Content.ReadAsStringAsync());

            var jsonResponse = await response.Content.ReadFromJsonAsync<JsonElement>();
            return jsonResponse.GetProperty("choices")[0].GetProperty("message").GetProperty("content").GetString() ?? "";
        }

        // ==========================================
        // 🎯 دوال منصة عون (بلمسة إنسانية)
        // ==========================================

        public async Task<string> GetRecommendationsAsync(string userHistory, string availableCases)
        {
            string sysPrompt = "أنت موظف بشري ودود في خدمة عملاء منصة 'عون'. تحدث مع المتبرع مباشرة ورشح له 3 حالات تناسبه من القائمة باختصار وبأسلوب إنساني دافئ. (مثال: أهلاً بك ، بناءً على تبرعاتك السابقة أنصحك بـ...)";
            string usrPrompt = $"تاريخ المتبرع: {userHistory}\nالحالات المتاحة حالياً: {availableCases}";
            return await AskAIWithFallbackAsync(sysPrompt, usrPrompt);
        }

        public async Task<string> ChatWithRAGAsync(string userQuestion, string dbContext)
        {
            string sysPrompt = $"أنت إنسان طبيعي تعمل في منصة (عون). أجب على السائل فوراً بلغة ودودة ومباشرة بناءً على هذه المعلومات فقط: {dbContext}. إذا سُئلت عن الزكاة، احسبها فوراً (المبلغ × 2.5%) وأعطه الناتج النهائي بلا إطالة.";
            string usrPrompt = $"السؤال: {userQuestion}";
            return await AskAIWithFallbackAsync(sysPrompt, usrPrompt);
        }

        public async Task<string> GenerateCaseDescriptionAsync(string title, string category, decimal requiredAmount)
        {
            string sysPrompt = "اكتب وصفاً تسويقياً وإنسانياً مؤثراً لهذه الحالة لجذب التبرعات. ادخل في صلب الموضوع مباشرة بدون أي مقدمات أو تحيات. النص يجب ألا يتجاوز 3 أسطر.";
            string usrPrompt = $"العنوان: {title} | التصنيف: {category} | المبلغ: {requiredAmount}";
            return await AskAIWithFallbackAsync(sysPrompt, usrPrompt);
        }
    }
}