using Mindscape.LightSpeed;

namespace DataAccess.LightSpeed
{
  /// <remarks>
  /// We had to switch smallint to int due to lack of support for Int16 in TypeModel
  /// </remarks>
  public class Product : Entity<int>
  {
    private readonly EntityHolder<Supplier> _supplier = new EntityHolder<Supplier>();

    // Required for reverse association
    private readonly EntityCollection<OrderDetail> _orderDetails = new EntityCollection<OrderDetail>();

    private string _productName;
    private int _supplierId;
    private int _categoryId;
    private string _quantityPerUnit;
    private decimal? _unitPrice;
    private int? _unitsInStock;
    private int? _reorderLevel;
    private bool _discontinued;

    public string ProductName
    {
      get { return _productName; }
      set { Set(ref _productName, value); }
    }

    public int SupplierId
    {
      get { return _supplierId; }
      set { Set(ref _supplierId, value); }
    }

    public int CategoryId
    {
      get { return _categoryId; }
      set { Set(ref _categoryId, value); }
    }

    public string QuantityPerUnit
    {
      get { return _quantityPerUnit; }
      set { Set(ref _quantityPerUnit, value); }
    }

    public decimal? UnitPrice
    {
      get { return _unitPrice; }
      set { Set(ref _unitPrice, value); }
    }

    public int? UnitsInStock
    {
      get { return _unitsInStock; }
      set { Set(ref _unitsInStock, value); }
    }

    public int? ReorderLevel
    {
      get { return _reorderLevel; }
      set { Set(ref _reorderLevel, value); }
    }

    public bool Discontinued
    {
      get { return _discontinued; }
      set { Set(ref _discontinued, value); }
    }

    public Supplier Supplier
    {
      get { return Get(_supplier); }
      set { Set(_supplier, value); }
    }

    public EntityCollection<OrderDetail> OrderDetails
    {
      get { return Get(_orderDetails); }
    }
  }
}