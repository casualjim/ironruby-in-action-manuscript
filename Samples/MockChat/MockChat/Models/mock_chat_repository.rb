
module MockChat

  module Models

    LSEntity = Mindscape::LightSpeed::Entity.to_a.first

    class MockChatRepository

      def users
        uow.method(:find).of(User).call
      end

      def messages
        query = Mindscape::LightSpeed::Querying::Query.new
        query.order = Order.by(LSEntity.attribute("CreatedOn")).descending
        uow.method(:find).of(ChatMessage).overload(Mindscape::LightSpeed::Querying::Query).call(query)
      end

      def find_user_by_username(username)
        uow.method(:find_one).of(User).call LSEntity.attribute("Username") == username
      end

      def find_user_by_id(id)
        uow.method(:find_one).of(User).call id
      end

      def find_last_30_messages
        query = Query.create_from_hash :page => Page.at(0, 30), :order => Order.by(LSEntity.attribute("CreatedOn")).descending
        uow.method(:find).of(ChatMessage).overload(Query).call query
      end

      def find_current_subject
        query = Query.create_from_hash :order => Order.by(LSEntity.attribute("CreatedOn")).descending
        uow.method(:find_one).of(ChatSession).call query
      end

      def save(entity)
        uow.add(entity) if entity.entity_state == EntityState.new
        uow.save_changes
      end

      def remove(entity)
        uow.remove(entity)
        uow.save_changes
      end
    
    end

  end
end