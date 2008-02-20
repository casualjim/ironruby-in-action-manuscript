namespace DataAccess.ActiveRecord
{
	// Business class Product generated from Products
	// Ivan Porto Carrero [2008-02-13] Created

	using System;
	using System.ComponentModel;
	using Castle.ActiveRecord;
    using System.Collections;
    using Castle.Components.Validator;
    using System.Collections.Generic;

	[ActiveRecord("Products")]
	public partial class Product 
		: ActiveRecordValidationBase<Product> 
		, INotifyPropertyChanged
	{

		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProductName = "ProductName";
		public static string Prop_SupplierId = "SupplierId";
		public static string Prop_CategoryId = "CategoryId";
		public static string Prop_QuantityPerUnit = "QuantityPerUnit";
		public static string Prop_UnitPrice = "UnitPrice";
		public static string Prop_UnitsInStock = "UnitsInStock";
		public static string Prop_UnitsOnOrder = "UnitsOnOrder";
		public static string Prop_ReorderLevel = "ReorderLevel";
		public static string Prop_Discontinued = "Discontinued";

		#endregion

		#region Private_Variables

		private int _id;
		private string _productName;
		private Supplier _supplierId;
		private Category _categoryId;
		private string _quantityPerUnit;
		private System.Decimal? _unitPrice;
		private int? _unitsInStock;
		private int? _unitsOnOrder;
		private int? _reorderLevel;
		private bool _discontinued;

		private IList _OrderDetails = new List<OrderDetail>();

		#endregion

		#region Constructors

		public Product()
		{
		}

		public Product(
			int p_id,
			string p_productName,
			Supplier p_supplierId,
			Category p_categoryId,
			string p_quantityPerUnit,
			System.Decimal? p_unitPrice,
			int? p_unitsInStock,
			int? p_unitsOnOrder,
			int? p_reorderLevel,
			bool p_discontinued)
		{
			_id = p_id;
			_productName = p_productName;
			_supplierId = p_supplierId;
			_categoryId = p_categoryId;
			_quantityPerUnit = p_quantityPerUnit;
			_unitPrice = p_unitPrice;
			_unitsInStock = p_unitsInStock;
			_unitsOnOrder = p_unitsOnOrder;
			_reorderLevel = p_reorderLevel;
			_discontinued = p_discontinued;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public int Id
		{
			get { return _id; }
		}

		[Property("ProductName", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 40), ValidateLength(1, 40)]
		public string ProductName
		{
			get { return _productName; }
			set
			{
				if ((_productName == null) || (value == null) || (!value.Equals(_productName)))
				{
					_productName = value;
					NotifyPropertyChanged(Product.Prop_ProductName);
				}
			}
		}

		[BelongsTo("SupplierId", Type = typeof(Supplier), Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public Supplier SupplierId
		{
			get { return _supplierId; }
			set
			{
				if ((_supplierId == null) || (value == null) || (value.Id != _supplierId.Id))
				{
					if (value == null)
						_supplierId = null;
					else
						_supplierId = (value.Id > 0) ? value : null;
					NotifyPropertyChanged(Product.Prop_SupplierId);
				}
			}
		}

		[BelongsTo("CategoryId", Type = typeof(Category), Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public Category CategoryId
		{
			get { return _categoryId; }
			set
			{
				if ((_categoryId == null) || (value == null) || (value.Id != _categoryId.Id))
				{
					if (value == null)
						_categoryId = null;
					else
						_categoryId = (value.Id > 0) ? value : null;
					NotifyPropertyChanged(Product.Prop_CategoryId);
				}
			}
		}

		[Property("QuantityPerUnit", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20), ValidateLength(1, 20)]
		public string QuantityPerUnit
		{
			get { return _quantityPerUnit; }
			set
			{
				if ((_quantityPerUnit == null) || (value == null) || (!value.Equals(_quantityPerUnit)))
				{
					_quantityPerUnit = value;
					NotifyPropertyChanged(Product.Prop_QuantityPerUnit);
				}
			}
		}

		[Property("UnitPrice", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? UnitPrice
		{
			get { return _unitPrice; }
			set
			{
				if (value != _unitPrice)
				{
					_unitPrice = value;
					NotifyPropertyChanged(Product.Prop_UnitPrice);
				}
			}
		}

		[Property("UnitsInStock", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? UnitsInStock
		{
			get { return _unitsInStock; }
			set
			{
				if (value != _unitsInStock)
				{
					_unitsInStock = value;
					NotifyPropertyChanged(Product.Prop_UnitsInStock);
				}
			}
		}

		[Property("UnitsOnOrder", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? UnitsOnOrder
		{
			get { return _unitsOnOrder; }
			set
			{
				if (value != _unitsOnOrder)
				{
					_unitsOnOrder = value;
					NotifyPropertyChanged(Product.Prop_UnitsOnOrder);
				}
			}
		}

		[Property("ReorderLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? ReorderLevel
		{
			get { return _reorderLevel; }
			set
			{
				if (value != _reorderLevel)
				{
					_reorderLevel = value;
					NotifyPropertyChanged(Product.Prop_ReorderLevel);
				}
			}
		}

		[Property("Discontinued", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true)]
		public bool Discontinued
		{
			get { return _discontinued; }
			set
			{
				if (value != _discontinued)
				{
					_discontinued = value;
					NotifyPropertyChanged(Product.Prop_Discontinued);
				}
			}
		}

	[HasMany(typeof(OrderDetail), Table="OrderDetails", ColumnKey="ProductId")]
	public IList OrderDetails
	{
	    get { return _OrderDetails; }
	    set { _OrderDetails = value; }
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

	} // Product
}

