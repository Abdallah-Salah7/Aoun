using Stripe;
using Stripe.Checkout;
using Microsoft.Extensions.Configuration;

namespace Aoun.BLL.Services.Zakat
{
    public class StripeService
    {
        private readonly IConfiguration _config;

        public StripeService(IConfiguration config)
        {
            // Initialize Stripe Key from configuration
            StripeConfiguration.ApiKey = config["Stripe:SecretKey"];
            _config = config;
        }

        public async Task<string> CreateCheckoutSession(decimal amount, string userId)
        {
            var options = new SessionCreateOptions
            {
                PaymentMethodTypes = new List<string> { "card" },
                LineItems = new List<SessionLineItemOptions>
        {
            new()
            {
                PriceData = new SessionLineItemPriceDataOptions
                {
                    UnitAmount = (long)Math.Round(amount * 100, 0), // Convert to Cents
                    Currency = "egp",
                    ProductData = new SessionLineItemPriceDataProductDataOptions
                    {
                        Name = "Aoun Zakat Payment", // Fixed name for the receipt
                        Description = $"Zakat contribution for User ID: {userId}",
                    },
                },
                Quantity = 1,
            },
        },
                Mode = "payment",
                // Metadata: This is crucial for Webhooks later
                Metadata = new Dictionary<string, string>
        {
            { "UserId", userId },
            { "PaymentType", "Zakat" }
        },
                SuccessUrl = _config["Stripe:SuccessUrl"] ?? "http://localhost:3000/success",
                CancelUrl = _config["Stripe:CancelUrl"] ?? "http://localhost:3000/cancel",
            };

            var service = new SessionService();
            var session = await service.CreateAsync(options);
            return session.Url;
        }

        }
    }
