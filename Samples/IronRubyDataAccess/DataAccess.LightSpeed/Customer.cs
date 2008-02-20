using Mindscape.LightSpeed;
using Mindscape.LightSpeed.Validation;

namespace DataAccess.LightSpeed
{
  public class Customer : Entity<int>
  {
    [ValidatePresence]
    [ValidateUnique]
    private string _customerID;

    [ValidatePresence]
    private string _companyName;

    private string _contactName;
    private string _contactTitle;
    private string _address;
    private string _city;
    private string _region;
    private string _postalCode;
    private string _country;
    private string _phone;
    private string _fax;

    private readonly EntityCollection<Order> _orders = new EntityCollection<Order>();

    public string CustomerID
    {
      get { return _customerID; }
      set { Set(ref _customerID, value); }
    }

    public string CompanyName
    {
      get { return _companyName; }
      set { Set(ref _companyName, value); }
    }

    public string ContactName
    {
      get { return _contactName; }
      set { Set(ref _contactName, value); }
    }

    public string ContactTitle
    {
      get { return _contactTitle; }
      set { Set(ref _contactTitle, value); }
    }

    public string Address
    {
      get { return _address; }
      set { Set(ref _address, value); }
    }

    public string City
    {
      get { return _city; }
      set { Set(ref _city, value); }
    }

    public string Region
    {
      get { return _region; }
      set { Set(ref _region, value); }
    }

    public string PostalCode
    {
      get { return _postalCode; }
      set { Set(ref _postalCode, value); }
    }

    public string Country
    {
      get { return _country; }
      set { Set(ref _country, value); }
    }

    public string Phone
    {
      get { return _phone; }
      set { Set(ref _phone, value); }
    }

    public string Fax
    {
      get { return _fax; }
      set { Set(ref _fax, value); }
    }

    public EntityCollection<Order> Orders
    {
      get { return Get(_orders); }
    }
  }
}