using Aoun.DAL.Data;
using Aoun.DAL.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Aoun.API.Controllers;

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
    [AllowAnonymous]
    [HttpGet("campaigns")]
    public async Task<IActionResult> GetCampaigns()
    {
        var campaigns = await _db.Cases
            .Where(c => !c.IsDeleted && (c.Category == "Campaign" || c.Status == CaseStatus.Urgent))
            .Select(c => new {
                c.Id,
                c.Title,
                c.RequiredAmount,
                c.CollectedAmount,
                IsUrgent = c.Status == CaseStatus.Urgent
            })
            .ToListAsync();
        return Ok(campaigns);
    }

    [HttpPost("donate")]
    public async Task<IActionResult> Donate([FromBody] DonationRequestDto request)
    {
        if (request.Amount <= 0)
            return BadRequest(new { message = "Donation amount must be greater than zero." });

        var targetCase = await _db.Cases.FirstOrDefaultAsync(c => c.Id == request.CaseId && !c.IsDeleted);

        if (targetCase == null)
            return NotFound(new { message = "Case not found." });

        if (targetCase.Status == CaseStatus.Rejected)
            return BadRequest(new { message = "Cannot donate to a rejected case." });

        var remaining = targetCase.RequiredAmount - targetCase.CollectedAmount;
        if (remaining <= 0)
            return BadRequest(new { message = "This case has already reached its goal." });

        var appliedAmount = Math.Min(request.Amount, remaining);
        targetCase.CollectedAmount += appliedAmount;

        var donorId = User.FindFirstValue(ClaimTypes.NameIdentifier);

        var donation = new Donation
        {
            CaseId = request.CaseId,
            Amount = appliedAmount,
            DonorId = donorId,
            PaymentMethod = string.IsNullOrWhiteSpace(request.PaymentMethod) ? "Credit Card" : request.PaymentMethod.Trim(),
            TransactionId = request.TransactionId?.Trim(),
            DonationDate = DateTime.UtcNow
        };

        _db.Donations.Add(donation);
        await _db.SaveChangesAsync();

        return Ok(new
        {
            message = "Donation successful!",
            donatedAmount = appliedAmount,
            currentAmount = targetCase.CollectedAmount,
            remainingAmount = targetCase.RequiredAmount - targetCase.CollectedAmount
        });
    }
}