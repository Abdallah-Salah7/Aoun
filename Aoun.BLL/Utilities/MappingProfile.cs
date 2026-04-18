
using Aoun.BLL.DTOs.Cases;
using Aoun.BLL.DTOs.Auth;
using Aoun.DAL.Entities;
using AutoMapper;
namespace Aoun.BLL.Utilities;
public class MappingProfile : Profile {
    public MappingProfile() {
        CreateMap<Case, CaseDto>()
            // حساب المبلغ المتبقي أوتوماتيك
            .ForMember(dest => dest.RemainingAmount, opt => opt.MapFrom(src => src.RequiredAmount - src.CollectedAmount))
            // تحويل الـ Enum لنص مقروء
            .ForMember(dest => dest.StatusName, opt => opt.MapFrom(src => src.Status.ToString()));
    }
}





