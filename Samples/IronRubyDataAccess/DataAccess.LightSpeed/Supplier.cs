using Mindscape.LightSpeed;

namespace DataAccess.LightSpeed
{
  public class Supplier : Entity<int>
  {
    // Required for reverse association
    private readonly EntityCollection<Product> _products = new EntityCollection<Product>();

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
    private string _homePage;

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

    public string HomePage
    {
      get { return _homePage; }
      set { Set(ref _homePage, value); }
    }

    public EntityCollection<Product> Products
    {
      get { return Get(_products); }
    }
  }
}