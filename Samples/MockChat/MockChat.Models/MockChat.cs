using System;

using Mindscape.LightSpeed;
using Mindscape.LightSpeed.Validation;
using Mindscape.LightSpeed.Linq;

namespace MockChat.Models
{
  [Serializable]
  [System.CodeDom.Compiler.GeneratedCode("LightSpeedModelGenerator", "1.0.0.0")]
  public partial class User : Entity<long>
  {
    #region Fields
  
    [ValidatePresence]
    [ValidateLength(0, 100)]
    private string _name;
    [ValidatePresence]
    [ValidateLength(0, 100)]
    [ValidateUnique]
    private string _username;
    [ValidatePresence]
    [ValidateEmailAddress]
    [ValidateLength(0, 100)]
    [ValidateUnique]
    private string _email;
    [ValidatePresence]
    [ValidateLength(0, 255)]
    private string _password;
    [ValidateLength(0, 100)]
    private string _salt;

    #pragma warning disable 649  // "Field is never assigned to" - LightSpeed assigns these fields internally
    private readonly int _lockVersion;
    private readonly System.DateTime _createdOn;
    private readonly System.DateTime _updatedOn;
    #pragma warning restore 649    

    #endregion
    
    #region Field attribute and view names
    
    public const string NameField = "Name";
    public const string UsernameField = "Username";
    public const string EmailField = "Email";
    public const string PasswordField = "Password";
    public const string SaltField = "Salt";


    #endregion
    
    #region Relationships

    [ReverseAssociation("CreatedBy")]
    private readonly EntityCollection<ChatMessage> _chatMessages = new EntityCollection<ChatMessage>();
    [ReverseAssociation("CreatedBy")]
    private readonly EntityCollection<ChatSession> _chatSessions = new EntityCollection<ChatSession>();
    [ReverseAssociation("User")]
    private readonly EntityCollection<RoomUser> _roomUsers = new EntityCollection<RoomUser>();
    [ReverseAssociation("CreatedBy")]
    private readonly EntityCollection<Room> _ownedRooms = new EntityCollection<Room>();

    #endregion
    
    #region Properties

    public EntityCollection<ChatMessage> ChatMessages
    {
      get { return Get(_chatMessages); }
    }

    public EntityCollection<ChatSession> ChatSessions
    {
      get { return Get(_chatSessions); }
    }

    public EntityCollection<RoomUser> RoomUsers
    {
      get { return Get(_roomUsers); }
    }

    public EntityCollection<Room> OwnedRooms
    {
      get { return Get(_ownedRooms); }
    }

    public string Name
    {
      get { return Get(ref _name); }
      set { Set(ref _name, value, "Name"); }
    }

    public string Username
    {
      get { return Get(ref _username); }
      set { Set(ref _username, value, "Username"); }
    }

    public string Email
    {
      get { return Get(ref _email); }
      set { Set(ref _email, value, "Email"); }
    }

    public string Password
    {
      get { return Get(ref _password); }
      set { Set(ref _password, value, "Password"); }
    }

    public string Salt
    {
      get { return Get(ref _salt); }
      set { Set(ref _salt, value, "Salt"); }
    }
    public int LockVersion
    {
      get { return _lockVersion; }
    }

    public System.DateTime CreatedOn
    {
      get { return _createdOn; }
    }

    public System.DateTime UpdatedOn
    {
      get { return _updatedOn; }
    }

    #endregion
  }

  [Serializable]
  [System.CodeDom.Compiler.GeneratedCode("LightSpeedModelGenerator", "1.0.0.0")]
  public partial class ChatSession : Entity<long>
  {
    #region Fields
  
    [Indexed]
    [ValidateLength(0, 150)]
    [ValidateUnique]
    private string _name;
    private long _createdById;
    private long _roomId;

    #pragma warning disable 649  // "Field is never assigned to" - LightSpeed assigns these fields internally
    private readonly int _lockVersion;
    private readonly System.DateTime _createdOn;
    private readonly System.DateTime _updatedOn;
    #pragma warning restore 649    

    #endregion
    
    #region Field attribute and view names
    
    public const string NameField = "Name";
    public const string CreatedByIdField = "CreatedById";
    public const string RoomIdField = "RoomId";


    #endregion
    
    #region Relationships

    [OrderBy("CreatedOn")]
    [ReverseAssociation("ChatSession")]
    private readonly EntityCollection<ChatMessage> _chatMessages = new EntityCollection<ChatMessage>();
    [ReverseAssociation("ChatSessions")]
    private readonly EntityHolder<User> _createdBy = new EntityHolder<User>();
    [ReverseAssociation("ChatSessions")]
    private readonly EntityHolder<Room> _room = new EntityHolder<Room>();

    #endregion
    
    #region Properties

    public EntityCollection<ChatMessage> ChatMessages
    {
      get { return Get(_chatMessages); }
    }

    public User CreatedBy
    {
      get { return Get(_createdBy); }
      set { Set(_createdBy, value); }
    }

    public Room Room
    {
      get { return Get(_room); }
      set { Set(_room, value); }
    }

    public string Name
    {
      get { return Get(ref _name); }
      set { Set(ref _name, value, "Name"); }
    }

    public long CreatedById
    {
      get { return Get(ref _createdById); }
      set { Set(ref _createdById, value, "CreatedById"); }
    }

    public long RoomId
    {
      get { return Get(ref _roomId); }
      set { Set(ref _roomId, value, "RoomId"); }
    }
    public int LockVersion
    {
      get { return _lockVersion; }
    }

    public System.DateTime CreatedOn
    {
      get { return _createdOn; }
    }

    public System.DateTime UpdatedOn
    {
      get { return _updatedOn; }
    }

    #endregion
  }

  [Serializable]
  [System.CodeDom.Compiler.GeneratedCode("LightSpeedModelGenerator", "1.0.0.0")]
  public partial class ChatMessage : Entity<long>
  {
    #region Fields
  
    [Indexed]
    [ValidatePresence]
    private string _body;
    private long _createdById;
    private long _chatSessionId;

    #pragma warning disable 649  // "Field is never assigned to" - LightSpeed assigns these fields internally
    private readonly int _lockVersion;
    private readonly System.DateTime _createdOn;
    private readonly System.DateTime _updatedOn;
    #pragma warning restore 649    

    #endregion
    
    #region Field attribute and view names
    
    public const string BodyField = "Body";
    public const string CreatedByIdField = "CreatedById";
    public const string ChatSessionIdField = "ChatSessionId";


    #endregion
    
    #region Relationships

    [ReverseAssociation("ChatMessages")]
    private readonly EntityHolder<User> _createdBy = new EntityHolder<User>();
    [EagerLoad]
    [ReverseAssociation("ChatMessages")]
    private readonly EntityHolder<ChatSession> _chatSession = new EntityHolder<ChatSession>();

    #endregion
    
    #region Properties

    public User CreatedBy
    {
      get { return Get(_createdBy); }
      set { Set(_createdBy, value); }
    }

    public ChatSession ChatSession
    {
      get { return Get(_chatSession); }
      set { Set(_chatSession, value); }
    }

    public string Body
    {
      get { return Get(ref _body); }
      set { Set(ref _body, value, "Body"); }
    }

    public long CreatedById
    {
      get { return Get(ref _createdById); }
      set { Set(ref _createdById, value, "CreatedById"); }
    }

    public long ChatSessionId
    {
      get { return Get(ref _chatSessionId); }
      set { Set(ref _chatSessionId, value, "ChatSessionId"); }
    }
    public int LockVersion
    {
      get { return _lockVersion; }
    }

    public System.DateTime CreatedOn
    {
      get { return _createdOn; }
    }

    public System.DateTime UpdatedOn
    {
      get { return _updatedOn; }
    }

    #endregion
  }

  [Serializable]
  [System.CodeDom.Compiler.GeneratedCode("LightSpeedModelGenerator", "1.0.0.0")]
  public partial class RoomUser : Entity<long>
  {
    #region Fields
  
    private long _userId;
    private long _roomId;

    #endregion
    
    #region Field attribute and view names
    
    public const string UserIdField = "UserId";
    public const string RoomIdField = "RoomId";


    #endregion
    
    #region Relationships

    [ReverseAssociation("RoomUsers")]
    private readonly EntityHolder<User> _user = new EntityHolder<User>();
    [ReverseAssociation("RoomUsers")]
    private readonly EntityHolder<Room> _room = new EntityHolder<Room>();

    #endregion
    
    #region Properties

    public User User
    {
      get { return Get(_user); }
      set { Set(_user, value); }
    }

    public Room Room
    {
      get { return Get(_room); }
      set { Set(_room, value); }
    }

    public long UserId
    {
      get { return Get(ref _userId); }
      set { Set(ref _userId, value, "UserId"); }
    }

    public long RoomId
    {
      get { return Get(ref _roomId); }
      set { Set(ref _roomId, value, "RoomId"); }
    }

    #endregion
  }

  [Serializable]
  [System.CodeDom.Compiler.GeneratedCode("LightSpeedModelGenerator", "1.0.0.0")]
  [Table("Room")]
  public partial class Room : Entity<long>
  {
    #region Fields
  
    [ValidatePresence]
    [ValidateLength(0, 50)]
    private string _name;
    private long _createdById;

    #pragma warning disable 649  // "Field is never assigned to" - LightSpeed assigns these fields internally
    private readonly int _lockVersion;
    private readonly System.DateTime _createdOn;
    private readonly System.DateTime _updatedOn;
    #pragma warning restore 649    

    #endregion
    
    #region Field attribute and view names
    
    public const string NameField = "Name";
    public const string CreatedByIdField = "CreatedById";


    #endregion
    
    #region Relationships

    [ReverseAssociation("Room")]
    private readonly EntityCollection<ChatSession> _chatSessions = new EntityCollection<ChatSession>();
    [ReverseAssociation("Room")]
    private readonly EntityCollection<RoomUser> _roomUsers = new EntityCollection<RoomUser>();
    [ReverseAssociation("OwnedRooms")]
    private readonly EntityHolder<User> _createdBy = new EntityHolder<User>();

    #endregion
    
    #region Properties

    public EntityCollection<ChatSession> ChatSessions
    {
      get { return Get(_chatSessions); }
    }

    public EntityCollection<RoomUser> RoomUsers
    {
      get { return Get(_roomUsers); }
    }

    public User CreatedBy
    {
      get { return Get(_createdBy); }
      set { Set(_createdBy, value); }
    }

    public string Name
    {
      get { return Get(ref _name); }
      set { Set(ref _name, value, "Name"); }
    }

    public long CreatedById
    {
      get { return Get(ref _createdById); }
      set { Set(ref _createdById, value, "CreatedById"); }
    }
    public int LockVersion
    {
      get { return _lockVersion; }
    }

    public System.DateTime CreatedOn
    {
      get { return _createdOn; }
    }

    public System.DateTime UpdatedOn
    {
      get { return _updatedOn; }
    }

    #endregion
  }


  [System.CodeDom.Compiler.GeneratedCode("LightSpeedModelGenerator", "1.0.0.0")]
  public partial class MockChatUnitOfWork : Mindscape.LightSpeed.UnitOfWork
  {
    [System.ComponentModel.EditorBrowsable(System.ComponentModel.EditorBrowsableState.Never)]
    public MockChatUnitOfWork()
    {
    }
    

    public System.Linq.IQueryable<User> Users
    {
      get { return this.Query<User>(); }
    }
    
    public System.Linq.IQueryable<ChatSession> ChatSessions
    {
      get { return this.Query<ChatSession>(); }
    }
    
    public System.Linq.IQueryable<ChatMessage> ChatMessages
    {
      get { return this.Query<ChatMessage>(); }
    }
    
    public System.Linq.IQueryable<RoomUser> RoomUsers
    {
      get { return this.Query<RoomUser>(); }
    }
    
    public System.Linq.IQueryable<Room> Rooms
    {
      get { return this.Query<Room>(); }
    }
    
  }

}
