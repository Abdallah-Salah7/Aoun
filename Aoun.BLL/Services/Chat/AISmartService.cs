using Microsoft.Extensions.Configuration;
using System.Net.Http.Json;
using System.Text;
using System.Text.Json;

namespace Aoun.BLL.Services.Chat
{
    public class AISmartService
    {
        private readonly HttpClient _http;
        private readonly string _apiKey;

        // متغير سحري سيحفظ اسم الموديل الشغال أياً كان اسمه!
        private string _workingModelName = string.Empty;

        public AISmartService(HttpClient http, IConfiguration config)
        {
            _http = http;
            _apiKey = "REDACTED_GEMINI_KEY_2";
        }

        private async Task<string> AskGeminiAsync(string prompt)
        {
            // =================================================================
            // 1. السحر الهندسي: الاستكشاف التلقائي (Auto-Discovery)
            // =================================================================
            if (string.IsNullOrEmpty(_workingModelName))
            {
                string listModelsUrl = $"https://generativelanguage.googleapis.com/v1beta/models?key={_apiKey}";
                var listResponse = await _http.GetAsync(listModelsUrl);

                if (!listResponse.IsSuccessStatusCode)
                    throw new Exception("فشل الاتصال بجوجل لجلب النماذج!");

                var listJson = await listResponse.Content.ReadFromJsonAsync<JsonElement>();

                // البحث في قائمة جوجل عن أول موديل جيميناي صالح للمحادثة
                foreach (var model in listJson.GetProperty("models").EnumerateArray())
                {
                    var name = model.GetProperty("name").GetString();
                    var methods = model.GetProperty("supportedGenerationMethods").EnumerateArray().Select(m => m.GetString()).ToList();

                    if (methods.Contains("generateContent") && name != null && name.StartsWith("models/gemini"))
                    {
                        _workingModelName = name; // التقطنا الموديل الشغال (مثلاً: models/gemini-1.0-pro)
                        Console.WriteLine($"✅ Auto-Discovered Working Model: {_workingModelName}");
                        break;
                    }
                }

                if (string.IsNullOrEmpty(_workingModelName))
                    throw new Exception("مفتاحك لا يملك صلاحية لأي نموذج من نماذج جيميناي!");
            }

            // =================================================================
            // 2. إرسال الطلب للموديل الذي اكتشفناه تلقائياً
            // =================================================================
            string requestUrl = $"https://generativelanguage.googleapis.com/v1beta/{_workingModelName}:generateContent?key={_apiKey}";

            var requestBody = new
            {
                contents = new[] { new { parts = new[] { new { text = prompt } } } }
            };

            string jsonBody = JsonSerializer.Serialize(requestBody);
            var content = new StringContent(jsonBody, Encoding.UTF8, "application/json");

            var request = new HttpRequestMessage(HttpMethod.Post, requestUrl) { Content = content };
            var response = await _http.SendAsync(request);

            if (!response.IsSuccessStatusCode)
            {
                var errorDetails = await response.Content.ReadAsStringAsync();
                throw new Exception($"Google API Error: {errorDetails}");
            }

            var jsonResponse = await response.Content.ReadFromJsonAsync<JsonElement>();
            return jsonResponse.GetProperty("candidates")[0]
                               .GetProperty("content")
                               .GetProperty("parts")[0]
                               .GetProperty("text").GetString() ?? "";
        }

        // ==========================================
        // 1. Recommendation System 
        // ==========================================
        public async Task<string> GetRecommendationsAsync(string userHistory, string availableCases)
        {
            string prompt = $@"
                أنت خبير في التوصيات الخيرية في منصة 'عون'. 
                إليك تاريخ تبرعات المستخدم وتفضيلاته: {userHistory}
                وإليك قائمة الحالات المتاحة حالياً للتبرع: {availableCases}
                بناءً على هذه البيانات، اختر أفضل 3 حالات تناسب هذا المستخدم، واذكر اسم الحالة ولماذا رشحتها له في رد قصير ومحفز باللغة العربية.
            ";
            return await AskGeminiAsync(prompt);
        }

        // ==========================================
        // 2. RAG Chatbot 
        // ==========================================
        public async Task<string> ChatWithRAGAsync(string userQuestion, string dbContext)
        {
            string prompt = $@"
                أنت مساعد ذكي ولطيف اسمك 'عون' تعمل في منصة خيرية مصرية.
                مهمتك هي الإجابة على أسئلة المستخدمين بخصوص الزكاة، الصدقات، وحالات المنصة.
                
                التعليمات:
                - لا تخترع معلومات غير موجودة.
                - استخدم المعلومات التالية المستخرجة من قاعدة البيانات للإجابة:
                {dbContext}
                - كن إيجابياً ومحفزاً للخير.
                
                سؤال المستخدم: {userQuestion}
            ";
            return await AskGeminiAsync(prompt);
        }

        // ==========================================
        // 3. AI Description Generator 
        // ==========================================
        public async Task<string> GenerateCaseDescriptionAsync(string title, string category, decimal requiredAmount)
        {
            string prompt = $@"
                أنت كاتب محتوى إنساني محترف تعمل في مؤسسة خيرية.
                اكتب وصفاً مؤثراً، احترافياً، وغير مبالغ فيه لحالة خيرية تحتاج للتبرع باللغة العربية.
                بيانات الحالة: العنوان: {title} | التصنيف: {category} | المبلغ المطلوب: {requiredAmount} جنيه مصري
                اجعل الوصف في حدود 3 إلى 4 أسطر، واختمه بدعوة لطيفة للتبرع.
            ";
            return await AskGeminiAsync(prompt);
        }
    }
}