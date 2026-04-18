using Microsoft.AspNetCore.Authorization;
using Aoun.BLL.DTOs.Zakat;
using Microsoft.AspNetCore.Mvc;

namespace Aoun.API.Controllers.Zakat;

[ApiController]
[Route("api/[controller]")]

public class ZakatController : ControllerBase
{
    private readonly ZakatService _zakat;

    public ZakatController(ZakatService zakat) => _zakat = zakat;

    [HttpGet("calculate")]
    public IActionResult Calculate(string type = "Cash", decimal amount = 0, decimal assetPrice = 0)
    {
        if (amount < 0 || assetPrice < 0)
        {
            return BadRequest(new { message = "القيم يجب أن تكون أكبر من أو تساوي صفر" });
        }

        var zakatAmount = _zakat.CalculateZakat(amount, type, assetPrice);
        return Ok(new
        {
            Type = type,
            InputAmount = amount,
            AssetPrice = assetPrice,
            RequiredZakat = zakatAmount,
            Message = zakatAmount > 0 ? "بلغ النصاب، الزكاة واجبة أو تم حساب زكاة الفطر" : "لم يبلغ النصاب، لا زكاة"
        });
    }
}




