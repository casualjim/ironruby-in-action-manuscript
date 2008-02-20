namespace DataAccess.ActiveRecord
{
	// Business class OrderDetail generated from OrderDetails
	// Ivan Porto Carrero [2008-02-13] Created

	using System;
	using System.ComponentModel;
	using Castle.ActiveRecord;

	[ActiveRecord("OrderDetails")]
	public partial class OrderDetail 
		: ActiveRecordValidationBase<OrderDetail> 
		, INotifyPropertyChanged
	{

		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_OrderId = "OrderId";
		public static string Prop_ProductId = "ProductId";
		public static string Prop_UnitPrice = "UnitPrice";
		public static string Prop_Quantity = "Quantity";
		public static string Prop_Discount = "Discount";

		#endregion

		#region Private_Variables

		private int _id;
		private int _orderId;
		private Product _productId;
		private System.Decimal _unitPrice;
		private short _quantity;
		private double _discount;


		#endregion

		#region Constructors

		public OrderDetail()
		{
		}

		public OrderDetail(
			int p_id,
			int p_orderId,
			Product p_productId,
			System.Decimal p_unitPrice,
			short p_quantity,
			double p_discount)
		{
			_id = p_id;
			_orderId = p_orderId;
			_productId = p_productId;
			_unitPrice = p_unitPrice;
			_quantity = p_quantity;
			_discount = p_discount;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public int Id
		{
			get { return _id; }
		}

		[Property("OrderId", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true)]
		public int OrderId
		{
			get { return _orderId; }
			set
			{
				if (value != _orderId)
				{
					_orderId = value;
					NotifyPropertyChanged(OrderDetail.Prop_OrderId);
				}
			}
		}

		[BelongsTo("ProductId", Type = typeof(Product), Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public Product ProductId
		{
			get { return _productId; }
			set
			{
				if ((_productId == null) || (value == null) || (value.Id != _productId.Id))
				{
					if (value == null)
						_productId = null;
					else
						_productId = (value.Id > 0) ? value : null;
					NotifyPropertyChanged(OrderDetail.Prop_ProductId);
				}
			}
		}

		[Property("UnitPrice", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true)]
		public System.Decimal UnitPrice
		{
			get { return _unitPrice; }
			set
			{
				if (value != _unitPrice)
				{
					_unitPrice = value;
					NotifyPropertyChanged(OrderDetail.Prop_UnitPrice);
				}
			}
		}

		[Property("Quantity", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true)]
		public short Quantity
		{
			get { return _quantity; }
			set
			{
				if (value != _quantity)
				{
					_quantity = value;
					NotifyPropertyChanged(OrderDetail.Prop_Quantity);
				}
			}
		}

		[Property("Discount", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true)]
		public double Discount
		{
			get { return _discount; }
			set
			{
				if (value != _discount)
				{
					_discount = value;
					NotifyPropertyChanged(OrderDetail.Prop_Discount);
				}
			}
		}

		#endregion

		#region INotifyPropertyChanged Members

		public event PropertyChangedEventHandler PropertyChanged;

		private void NotifyPropertyChanged(String info)
		{
			PropertyChangedEventHandler localPropertyChanged = PropertyChanged;
			if (localPropertyChanged != null)
			{
				localPropertyChanged(this, new PropertyChangedEventArgs(info));
			}
		}

		#endregion

	} // OrderDetail
}

