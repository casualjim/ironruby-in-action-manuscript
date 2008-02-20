using System;
using Mindscape.LightSpeed;
using Mindscape.LightSpeed.Validation;

namespace DataAccess.LightSpeed
{
  public class Employee : Entity<int>
  {
    [ValidatePresence]
    private string _lastName;

    [ValidatePresence]
    private string _firstName;

    private readonly EntityCollection<Employee> _reports = new EntityCollection<Employee>();
    private readonly EntityHolder<Employee> _reportsTo = new EntityHolder<Employee>();

    // Required for reverse association
    private readonly EntityCollection<Order> _orders = new EntityCollection<Order>();

    private string _title;
    private string _titleOfCourtesy;
    private DateTime _birthDate;
    private DateTime _hireDate;
    private string _address;
    private string _city;
    private string _region;
    private string _postalCode;
    private string _country;
    private string _homePhone;
    private string _extension;
    private byte[] _photo;
    private string _notes;
    private int? _reportsToId;
    private string _photoPath;

    public string LastName
    {
      get { return _lastName; }
      set { Set(ref _lastName, value); }
    }

    public string FirstName
    {
      get { return _firstName; }
      set { Set(ref _firstName, value); }
    }

    public string Title
    {
      get { return _title; }
      set { Set(ref _title, value); }
    }

    public string TitleOfCourtesy
    {
      get { return _titleOfCourtesy; }
      set { Set(ref _titleOfCourtesy, value); }
    }

    public DateTime BirthDate
    {
      get { return _birthDate; }
      set { Set(ref _birthDate, value); }
    }

    public DateTime HireDate
    {
      get { return _hireDate; }
      set { Set(ref _hireDate, value); }
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

    public string HomePhone
    {
      get { return _homePhone; }
      set { Set(ref _homePhone, value); }
    }

    public string Extension
    {
      get { return _extension; }
      set { Set(ref _extension, value); }
    }

    public byte[] Photo
    {
      get { return _photo; }
      set { Set(ref _photo, value); }
    }

    public string Notes
    {
      get { return _notes; }
      set { Set(ref _notes, value); }
    }

    public string PhotoPath
    {
      get { return _photoPath; }
      set { Set(ref _photoPath, value); }
    }

    public Employee ReportsTo
    {
      get { return Get(_reportsTo); }
      set { Set(_reportsTo, value); }
    }

    public int? ReportsToId
    {
      get { return _reportsToId; }
      set { _reportsToId = value; }
    }

    public EntityCollection<Order> Orders
    {
      get { return _orders; }
    }

    public EntityCollection<Employee> Reports
    {
      get { return Get(_reports); }
    }
  }
}