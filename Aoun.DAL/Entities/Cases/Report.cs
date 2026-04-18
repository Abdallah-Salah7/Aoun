
using System;
namespace Aoun.DAL.Entities;
public class Report {
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public bool IsDeleted { get; set; } = false;
    public int? CaseId { get; set; }
    public Case? Case { get; set; }
}









