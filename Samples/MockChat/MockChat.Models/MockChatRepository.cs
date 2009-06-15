using System.Collections.Generic;
using System.Linq;
using Mindscape.LightSpeed;
using Mindscape.LightSpeed.Querying;

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
//            var query = new Query
//                            {
//                                Page = Page.At(0, 30), 
//                                Order = Order.By(Entity.Attribute("CreatedOn")).Descending()
//                            };
//            return UnitOfWorkScope.Current.Find<ChatMessage>(query);
//        }
    }
}