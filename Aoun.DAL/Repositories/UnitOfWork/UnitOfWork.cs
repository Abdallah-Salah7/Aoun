
using Aoun.DAL.Data;
using Aoun.DAL.Repositories.CaseRepo;
using Aoun.DAL.Repositories.Generic;
using System.Threading.Tasks;

namespace Aoun.DAL.Repositories.UnitOfWork;

public class UnitOfWork : IUnitOfWork {
    private readonly ApplicationDbContext _context;
    public ICaseRepository Cases { get; private set; }

    public UnitOfWork(ApplicationDbContext context) {
        _context = context;
        // تعريف الـ Repository المخصص
        Cases = new CaseRepository(_context);
    }

    public IGenericRepository<TEntity> Repository<TEntity>() where TEntity : class {
        return new GenericRepository<TEntity>(_context);
    }

    public async Task<int> CompleteAsync() => await _context.SaveChangesAsync();
    public void Dispose() => _context.Dispose();
}





