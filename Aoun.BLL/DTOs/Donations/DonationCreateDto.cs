namespace Aoun.BLL.DTOs.Donations
{
    public class DonationCreateDto
    {
        //public decimal Amount { get; set; }

        //public string TargetType { get; set; } // Case / Campaign / Charity
        //public int TargetId { get; set; }
        //public int UserId { get; set; }   //هيتشال بعدين 

        //public bool IsGift { get; set; }

        //public string? GiftReceiverName { get; set; }
        //public string? GiftReceiverPhone { get; set; }
        //public string? GiftMessage { get; set; }

        //// Payment
        //public string CardNumber { get; set; }
        //public string ExpiryDate { get; set; }
        //public string CVV { get; set; }
        //public string CardHolderName { get; set; }

        public int? UserId { get; set; }
        public string DonorName { get; set; }=null!;
        public decimal Amount { get; set; }
        public string TargetType { get; set; }
        public int TargetId { get; set; }
        public bool IsGift { get; set; }
        public string? GiftReceiverName { get; set; }
        public string? GiftReceiverPhone { get; set; }
        public string? GiftMessage { get; set; }
        // ✅ شيلنا CardNumber و ExpiryDate و CVV و CardHolderName من هنا لأننا مش هنتعامل معاهم في ال DTO ده، هنتعامل معاهم في PaymentDto اللي هي خاصة بعملية الدفع فقط، وده هيخلي ال DTO بتاع التبرع أبسط وأوضح، وكمان هيخلي عملية التحقق من البيانات أسهل، لأن بيانات الدفع ممكن تكون معقدة شوية ومحتاجة تحقق خاص بيها.
    }
}
