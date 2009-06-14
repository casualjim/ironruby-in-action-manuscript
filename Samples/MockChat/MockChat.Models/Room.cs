using System.Collections.Generic;
using Mindscape.LightSpeed;

namespace MockChat.Models
{
    public partial class Room
    {
        private readonly ThroughAssociation<RoomUser, User> _joinedUsers;

        public Room()
        {
            _joinedUsers = new ThroughAssociation<RoomUser, User>(_roomUsers);
        }

        public IList<User> JoinedUsers
        {
            get { return Get(_joinedUsers); }
        }
    }
}