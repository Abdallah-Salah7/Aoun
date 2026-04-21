
using Aoun.BLL.DTOs.Auth;
using Aoun.BLL.DTOs.Cases;
using AutoMapper;
using Aoun.DAL.Entities;

namespace Aoun.BLL.Mapping;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<RegisterDto, ApplicationUser>().ForMember(dest => dest.UserName, opt => opt.MapFrom(src => src.Email));
    }
}




