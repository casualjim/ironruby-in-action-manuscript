
module MockChat

  module Models

    LSEntity = Mindscape::LightSpeed::Entity.to_a.first

    class MockChatRepository

      include Lightspeed::Finder

      def users
        uow.method(:find).of(User).call
      end

      def messages
        query = Query.new(ChatMessage.to_clr_type)
        query.order = Order.by(LSEntity.attribute("CreatedOn")).descending
        uow.method(:find).overload(Query).call(query)
      end

      def find_user_by_username(username)
        uow.method(:find_one).of(User).call LSEntity.attribute("Username") == username
      end

      def find_user_by_id(id)
        uow.method(:find_one).of(User).call id
      end

      def find_last_30_messages
        query = Query.new(ChatMessage.to_clr_type)
        query.populate_from_hash :page => Page.at(0, 30), :order => Order.by(LSEntity.attribute("CreatedOn")).descending
        uow.method(:find).overload(Query).call query
      end

      def find_current_subject
        query = Query.new(ChatSession.to_clr_type)
        query.populate_from_hash :order => Order.by(LSEntity.attribute("CreatedOn")).descending
        uow.method(:find).call(query).first
      end

      def find_current_room
        uow.method(:find_one).of(Room).call(1)
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