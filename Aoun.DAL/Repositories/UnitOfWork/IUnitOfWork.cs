
using Aoun.DAL.Repositories.CaseRepo;
using Aoun.DAL.Repositories.Generic;
using System;
using System.Threading.Tasks;

namespace Aoun.DAL.Repositories.UnitOfWork;

public interface IUnitOfWork : IDisposable {
    // الـ Repositories المخصصة
    ICaseRepository Cases { get; }
    
    // الـ Generic للحاجات البسيطة
    IGenericRepository<TEntity> Repository<TEntity>() where TEntity : class;
    
    Task<int> CompleteAsync();
}





