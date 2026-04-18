namespace Aoun.BLL.DTOs.Zakat;

public class ZakatService
{
    public decimal CalculateZakat(decimal amount, string type, decimal assetPrice)
    {
        var zakatRate = 0.025m;
        var normalizedType = (type ?? string.Empty).Trim().ToLowerInvariant();

        return normalizedType switch
        {
            "gold" => assetPrice > 0 && amount >= (85m * assetPrice) ? amount * zakatRate : 0m,
            "silver" => assetPrice > 0 && amount >= (595m * assetPrice) ? amount * zakatRate : 0m,
            "fitr" or "zakatfitr" => amount > 0 && assetPrice > 0 ? amount * assetPrice : 0m,
            _ => amount > 0 ? amount * zakatRate : 0m
        };
    }
}
