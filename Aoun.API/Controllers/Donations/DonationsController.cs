using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Aoun.API.Controllers.Donations;

public class DonationRequestDto
{
    public int CaseId { get; set; }
    public decimal Amount { get; set; }
    public string PaymentMethod { get; set; } = "Credit Card";
    public string? TransactionId { get; set; }
}

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class DonationsController : ControllerBase
{
    private readonly ApplicationDbContext _db;

    public DonationsController(ApplicationDbContext db) => _db = db;

    [HttpPost("donate")]
    public async Task<IActionResult> Donate([FromBody] DonationRequestDto request)
    {
        if (request.Amount <= 0)
        {
            return BadRequest(new { message = "قيمة التبرع يجب أن تكون أكبر من صفر" });
        }

        var targetCase = await _db.Cases.FirstOrDefaultAsync(c => c.Id == request.CaseId && !c.IsDeleted);
        if (targetCase == null)
        {
            return NotFound(new { message = "الحالة غير موجودة" });
        }

        if (targetCase.Status == CaseStatus.Rejected)
        {
            return BadRequest(new { message = "لا يمكن التبرع لحالة مرفوضة" });
        }

        var remaining = targetCase.RequiredAmount - targetCase.CollectedAmount;
        if (remaining <= 0)
        {
            return BadRequest(new { message = "الحالة مكتملة بالفعل" });
        }

        var appliedAmount = Math.Min(request.Amount, remaining);
        targetCase.CollectedAmount += appliedAmount;

        var donorId = User.FindFirstValue(ClaimTypes.NameIdentifier);
        _db.Donations.Add(new Donation
        {
            CaseId = request.CaseId,
            Amount = appliedAmount,
            DonorId = donorId,
            PaymentMethod = string.IsNullOrWhiteSpace(request.PaymentMethod) ? "Credit Card" : request.PaymentMethod.Trim(),
            TransactionId = request.TransactionId?.Trim(),
            DonationDate = DateTime.UtcNow
        });

        await _db.SaveChangesAsync();

        return Ok(new
        {
            message = "✅ تم التبرع بنجاح!",
            donatedAmount = appliedAmount,
            currentAmount = targetCase.CollectedAmount,
            remainingAmount = targetCase.RequiredAmount - targetCase.CollectedAmount
        });
    }
}




