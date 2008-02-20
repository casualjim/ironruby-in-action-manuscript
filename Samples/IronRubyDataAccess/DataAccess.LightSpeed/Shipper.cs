using Mindscape.LightSpeed;

namespace DataAccess.LightSpeed
{
  public class Shipper : Entity<int>
  {
    // Required for reverse association
    private readonly EntityCollection<Order> _orders = new EntityCollection<Order>();

    private string _companyName;
    private string _phone;

    public string CompanyName
    {
      get { return _companyName; }
      set { Set(ref _companyName, value); }
    }

    public string Phone
    {
      get { return _phone; }
      set { Set(ref _phone, value); }
    }

    public EntityCollection<Order> Orders
    {
      get { return Get(_orders); }
    }
  }
}