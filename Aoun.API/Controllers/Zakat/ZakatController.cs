using Aoun.BLL.DTOs.Zakat;
using Aoun.BLL.Services.Zakat;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Stripe;
using System.Security.Claims;

namespace Aoun.API.Controllers.Zakat;

[ApiController]
[Route("api/zakat")]
public class ZakatController : ControllerBase
{
    private readonly ZakatService _zakat;
    private readonly StripeService _stripe;

    public ZakatController(ZakatService zakat, StripeService stripe)
    {
        _zakat = zakat;
        _stripe = stripe;
    }

    [HttpPost("calculate")]
    public async Task<IActionResult> Calculate(ZakatFullDto dto)
    {
        var result = await _zakat.Calculate(dto);
        return Ok(result);
    }
    [Authorize]
    [HttpPost("pay")]
    public async Task<IActionResult> PayZakat([FromBody] PaymentRequest request)
    {
        var userId = User.FindFirstValue(ClaimTypes.NameIdentifier) ?? User.FindFirst("sub")?.Value;

        if (string.IsNullOrEmpty(userId))
        {
            return Unauthorized(new { message = "User ID could not be extracted from the token." });
        }
        // 1. Backend Validation: Secure the amount
        if (request.Amount <= 0)
            return BadRequest(new { message = "Amount must be greater than zero." });

        try
        {
            // 2. Pass Amount and UserId to the service
            var checkoutUrl = await _stripe.CreateCheckoutSession(request.Amount, userId);

            return Ok(new { url = checkoutUrl });
        }
        catch (StripeException ex)
        {
            // Catch specific Stripe errors (like invalid API Keys)
            return BadRequest(new { message = $"Stripe Error: {ex.Message}" });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { message = $"An internal error occurred. {ex.Message}" });
        }
    }
}
