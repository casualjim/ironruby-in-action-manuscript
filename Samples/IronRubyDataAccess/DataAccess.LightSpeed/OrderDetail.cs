using System;
using Mindscape.LightSpeed;

namespace DataAccess.LightSpeed
{
  public class OrderDetail : Entity<int>
  {
    private int _orderId;
    private int _productId;
    private Single _discount;

    private readonly EntityHolder<Order> _order = new EntityHolder<Order>();
    private readonly EntityHolder<Product> _product = new EntityHolder<Product>();

    public Order Order
    {
      get { return Get(_order); }
      set { Set(_order, value); }
    }

    public int OrderId
    {
      get { return _orderId; }
      set { _orderId = value; }
    }

    public int ProductId
    {
      get { return _productId; }
      set { _productId = value; }
    }

    public Product Product
    {
      get { return Get(_product); }
      set { Set(_product, value); }
    }

    public Single Discount
    {
      get { return _discount; }
      set { Set(ref _discount, value); }
    }
  }
}