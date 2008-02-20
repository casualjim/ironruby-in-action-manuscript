using System;
using Mindscape.LightSpeed;

namespace DataAccess.LightSpeed
{
  public class Order : Entity<int>
  {
    [EagerLoad]
    private readonly EntityCollection<OrderDetail> _orderDetails = new EntityCollection<OrderDetail>();

    private readonly EntityHolder<Customer> _customer = new EntityHolder<Customer>();
    private readonly EntityHolder<Employee> _employee = new EntityHolder<Employee>();
    private readonly EntityHolder<Shipper> _shipVia = new EntityHolder<Shipper>();

    private int _customerId;
    private int _employeeId;
    private DateTime _orderDate;
    private DateTime _requiredDate;
    private DateTime _shippedDate;
    private int _shipViaId;
    private decimal _freight;
    private string _shipName;
    private string _shipAddress;
    private string _shipCity;
    private string _shipRegion;
    private string _shipPostalCode;
    private string _shipCountry;

    public EntityCollection<OrderDetail> Details
    {
      get { return Get(_orderDetails); }
    }

    public int EmployeeId
    {
      get { return _employeeId; }
      set { Set(ref _employeeId, value); }
    }

    public DateTime OrderDate
    {
      get { return _orderDate; }
      set { Set(ref _orderDate, value); }
    }

    public DateTime RequiredDate
    {
      get { return _requiredDate; }
      set { Set(ref _requiredDate, value); }
    }

    public DateTime ShippedDate
    {
      get { return _shippedDate; }
      set { Set(ref _shippedDate, value); }
    }

    public Shipper ShipVia
    {
      get { return Get(_shipVia); }
      set { Set(_shipVia, value); }
    }

    public decimal Freight
    {
      get { return _freight; }
      set { Set(ref _freight, value); }
    }

    public string ShipName
    {
      get { return _shipName; }
      set { Set(ref _shipName, value); }
    }

    public string ShipAddress
    {
      get { return _shipAddress; }
      set { Set(ref _shipAddress, value); }
    }

    public string ShipCity
    {
      get { return _shipCity; }
      set { Set(ref _shipCity, value); }
    }

    public string ShipRegion
    {
      get { return _shipRegion; }
      set { Set(ref _shipRegion, value); }
    }

    public string ShipPostalCode
    {
      get { return _shipPostalCode; }
      set { Set(ref _shipPostalCode, value); }
    }

    public string ShipCountry
    {
      get { return _shipCountry; }
      set { Set(ref _shipCountry, value); }
    }

    public Customer Customer
    {
      get { return Get(_customer); }
      set { Set(_customer, value); }
    }

    public int CustomerId
    {
      get { return _customerId; }
      set { Set(ref _customerId, value); }
    }

    public int ShipViaId
    {
      get { return _shipViaId; }
      set { Set(ref _shipViaId, value); }
    }

    public Employee Employee
    {
      get { return Get(_employee); }
      set { Set(_employee, value); }
    }
  }
}