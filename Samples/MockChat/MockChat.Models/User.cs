using System.Collections.Generic;
using System.Web.Security;
using Mindscape.LightSpeed;

namespace MockChat.Models
{
    public partial class User
    {
        private readonly ThroughAssociation<RoomUser, Room> _joinedRooms;

        public User()
        {
            _joinedRooms = new ThroughAssociation<RoomUser, Room>(_roomUsers);
        }

        public IList<Room> JoinedRooms
        {
            get
            {
                return Get(_joinedRooms);
            }
        }

        protected override void OnValidate()
        {
            
        }

    }
}