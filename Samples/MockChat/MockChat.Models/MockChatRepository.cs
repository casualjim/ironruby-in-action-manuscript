using System.Collections.Generic;
using System.Linq;
using Mindscape.LightSpeed;

namespace MockChat.Models
{
    public class MockChatRepository : RepositoryBase<MockChatUnitOfWork>
    {
        public MockChatRepository(UnitOfWorkScopeBase<MockChatUnitOfWork> unitOfWorkScope) : base(unitOfWorkScope)
        {
            
        }

        public IUnitOfWork Uow()
        {
            return UnitOfWorkScope.Current;
        }
        
//        public IEnumerable<ChatMessage> FindLast30Messages()
//        {
//            return 
//                UnitOfWorkScope
//                    .Current
//                    .ChatMessages
//                        .Take(30)
//                        .OrderByDescending(msg => msg.CreatedOn);
//        }
        
    }
}