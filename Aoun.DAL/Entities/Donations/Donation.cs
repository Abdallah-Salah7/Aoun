
using System;
namespace Aoun.DAL.Entities;
public class Donation {
    public int Id { get; set; }
    public int CaseId { get; set; }
    public Case? Case { get; set; }
    public decimal Amount { get; set; }
    public DateTime DonationDate { get; set; } = DateTime.Now;
    
    // إضافات شاشة الـ Payment
    public string PaymentMethod { get; set; } = "Credit Card"; 
    public string? TransactionId { get; set; }
    public bool IsDeleted { get; set; } = false;
    public string? DonorId { get; set; }
    public ApplicationUser? Donor { get; set; }
    public string? UserId { get; set; }
     public ApplicationUser? User { get; set; }
}









