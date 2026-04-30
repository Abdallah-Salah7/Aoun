using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
// 🔥 هنا عرفنا الاسم المستعار
using CharityEntity = Aoun.DAL.Entities.Charity.Charity;

namespace Aoun.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class AdminDashboardController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public AdminDashboardController(ApplicationDbContext context)
        {
            _context = context;
        }

        // ==========================================
        // 1. إحصائيات اللوحة الرئيسية
        // ==========================================
        [HttpGet("stats")]
        public async Task<IActionResult> GetDashboardStats()
        {
            try
            {
                var totalUsers = await _context.Set<User>().CountAsync();
                var totalDonations = await _context.Donations.SumAsync(d => (decimal?)d.Amount) ?? 0;
                var activeCases = await _context.Cases.CountAsync(c => c.CollectedAmount < c.RequiredAmount);

                // ✅ تم التغيير لـ CharityEntity
                var totalCharities = await _context.Set<CharityEntity>().CountAsync();

                var recentDonations = await _context.Donations
                    .OrderByDescending(d => d.CreatedAt)
                    .Take(5)
                    .Select(d => new { d.Amount, Date = d.CreatedAt.ToString("yyyy-MM-dd") })
                    .ToListAsync();

                return Ok(new { success = true, data = new { totalUsers, totalDonations, activeCases, totalCharities, recentDonations } });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = ex.Message });
            }
        }

        // ==========================================
        // 2. إدارة المستخدمين
        // ==========================================
        [HttpGet("users")]
        public async Task<IActionResult> GetUsers()
        {
            var users = await _context.Set<User>()
                .Select(u => new { u.Id, u.Email, u.UserName })
                .ToListAsync();
            return Ok(new { success = true, data = users });
        }

        [HttpDelete("users/{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            var user = await _context.Set<User>().FindAsync(id);
            if (user == null) return NotFound(new { message = "المستخدم غير موجود" });

            _context.Set<User>().Remove(user);
            await _context.SaveChangesAsync();
            return Ok(new { success = true, message = "تم الحذف بنجاح" });
        }

        // ==========================================
        // 3. إدارة الجمعيات
        // ==========================================
        [HttpGet("charities")]
        public async Task<IActionResult> GetCharities()
        {
            // ✅ تم التغيير لـ CharityEntity
            var charities = await _context.Set<CharityEntity>()
                .Select(c => new
                {
                    Id = c.Id,
                    Name = c.Name,
                    RegistrationNumber = c.LicenseNumber,
                    Status = c.IsApproved ? "Approved" : "Pending"
                })
                .ToListAsync();

            return Ok(new { success = true, data = charities });
        }

        public class StatusDto { public string Status { get; set; } }

        [HttpPut("charities/{id}/status")]
        public async Task<IActionResult> UpdateCharityStatus(int id, [FromBody] StatusDto dto)
        {
            // ✅ تم التغيير لـ CharityEntity
            var charity = await _context.Set<CharityEntity>().FindAsync(id);
            if (charity == null) return NotFound(new { message = "الجمعية غير موجودة" });

            charity.IsApproved = (dto.Status == "Approved");
            await _context.SaveChangesAsync();

            return Ok(new { success = true, message = "تم التحديث بنجاح" });
        }

        [HttpPost("add-admin")]
        public IActionResult AddAdmin([FromBody] AddAdminDto dto)
        {
            return Ok(new { success = true, message = "تمت محاكاة إضافة الأدمن بنجاح" });
        }

        public class AddAdminDto { public string Email { get; set; } public string Password { get; set; } public string FullName { get; set; } }
    }
}