namespace DataAccess.ActiveRecord
{
	// Business class Order generated from Orders
	// Ivan Porto Carrero [2008-02-13] Created

	using System;
	using System.ComponentModel;
	using Castle.ActiveRecord;
    using Castle.Components.Validator;

	[ActiveRecord("Orders")]
	public partial class Order 
		: ActiveRecordValidationBase<Order> 
		, INotifyPropertyChanged
	{

		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_CustomerId = "CustomerId";
		public static string Prop_EmployeeId = "EmployeeId";
		public static string Prop_OrderDate = "OrderDate";
		public static string Prop_RequiredDate = "RequiredDate";
		public static string Prop_ShippedDate = "ShippedDate";
		public static string Prop_ShipViaId = "ShipViaId";
		public static string Prop_Freight = "Freight";
		public static string Prop_ShipName = "ShipName";
		public static string Prop_ShipAddress = "ShipAddress";
		public static string Prop_ShipCity = "ShipCity";
		public static string Prop_ShipRegion = "ShipRegion";
		public static string Prop_ShipPostalCode = "ShipPostalCode";
		public static string Prop_ShipCountry = "ShipCountry";

		#endregion

		#region Private_Variables

		private int _id;
		private int? _customerId;
		private int? _employeeId;
		private DateTime? _orderDate;
		private DateTime? _requiredDate;
		private DateTime? _shippedDate;
		private int? _shipViaId;
		private System.Decimal? _freight;
		private string _shipName;
		private string _shipAddress;
		private string _shipCity;
		private string _shipRegion;
		private string _shipPostalCode;
		private string _shipCountry;


		#endregion

		#region Constructors

		public Order()
		{
		}

		public Order(
			int p_id,
			int? p_customerId,
			int? p_employeeId,
			DateTime? p_orderDate,
			DateTime? p_requiredDate,
			DateTime? p_shippedDate,
			int? p_shipViaId,
			System.Decimal? p_freight,
			string p_shipName,
			string p_shipAddress,
			string p_shipCity,
			string p_shipRegion,
			string p_shipPostalCode,
			string p_shipCountry)
		{
			_id = p_id;
			_customerId = p_customerId;
			_employeeId = p_employeeId;
			_orderDate = p_orderDate;
			_requiredDate = p_requiredDate;
			_shippedDate = p_shippedDate;
			_shipViaId = p_shipViaId;
			_freight = p_freight;
			_shipName = p_shipName;
			_shipAddress = p_shipAddress;
			_shipCity = p_shipCity;
			_shipRegion = p_shipRegion;
			_shipPostalCode = p_shipPostalCode;
			_shipCountry = p_shipCountry;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public int Id
		{
			get { return _id; }
		}

		[Property("CustomerId", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? CustomerId
		{
			get { return _customerId; }
			set
			{
				if (value != _customerId)
				{
					_customerId = value;
					NotifyPropertyChanged(Order.Prop_CustomerId);
				}
			}
		}

		[Property("EmployeeId", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? EmployeeId
		{
			get { return _employeeId; }
			set
			{
				if (value != _employeeId)
				{
					_employeeId = value;
					NotifyPropertyChanged(Order.Prop_EmployeeId);
				}
			}
		}

		[Property("OrderDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? OrderDate
		{
			get { return _orderDate; }
			set
			{
				if (value != _orderDate)
				{
					_orderDate = value;
					NotifyPropertyChanged(Order.Prop_OrderDate);
				}
			}
		}

		[Property("RequiredDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? RequiredDate
		{
			get { return _requiredDate; }
			set
			{
				if (value != _requiredDate)
				{
					_requiredDate = value;
					NotifyPropertyChanged(Order.Prop_RequiredDate);
				}
			}
		}

		[Property("ShippedDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ShippedDate
		{
			get { return _shippedDate; }
			set
			{
				if (value != _shippedDate)
				{
					_shippedDate = value;
					NotifyPropertyChanged(Order.Prop_ShippedDate);
				}
			}
		}

		[Property("ShipViaId", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? ShipViaId
		{
			get { return _shipViaId; }
			set
			{
				if (value != _shipViaId)
				{
					_shipViaId = value;
					NotifyPropertyChanged(Order.Prop_ShipViaId);
				}
			}
		}

		[Property("Freight", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? Freight
		{
			get { return _freight; }
			set
			{
				if (value != _freight)
				{
					_freight = value;
					NotifyPropertyChanged(Order.Prop_Freight);
				}
			}
		}

		[Property("ShipName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 40), ValidateLength(1, 40)]
		public string ShipName
		{
			get { return _shipName; }
			set
			{
				if ((_shipName == null) || (value == null) || (!value.Equals(_shipName)))
				{
					_shipName = value;
					NotifyPropertyChanged(Order.Prop_ShipName);
				}
			}
		}

		[Property("ShipAddress", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 60), ValidateLength(1, 60)]
		public string ShipAddress
		{
			get { return _shipAddress; }
			set
			{
				if ((_shipAddress == null) || (value == null) || (!value.Equals(_shipAddress)))
				{
					_shipAddress = value;
					NotifyPropertyChanged(Order.Prop_ShipAddress);
				}
			}
		}

		[Property("ShipCity", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 15), ValidateLength(1, 15)]
		public string ShipCity
		{
			get { return _shipCity; }
			set
			{
				if ((_shipCity == null) || (value == null) || (!value.Equals(_shipCity)))
				{
					_shipCity = value;
					NotifyPropertyChanged(Order.Prop_ShipCity);
				}
			}
		}

		[Property("ShipRegion", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 15), ValidateLength(1, 15)]
		public string ShipRegion
		{
			get { return _shipRegion; }
			set
			{
				if ((_shipRegion == null) || (value == null) || (!value.Equals(_shipRegion)))
				{
					_shipRegion = value;
					NotifyPropertyChanged(Order.Prop_ShipRegion);
				}
			}
		}

		[Property("ShipPostalCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10), ValidateLength(1, 10)]
		public string ShipPostalCode
		{
			get { return _shipPostalCode; }
			set
			{
				if ((_shipPostalCode == null) || (value == null) || (!value.Equals(_shipPostalCode)))
				{
					_shipPostalCode = value;
					NotifyPropertyChanged(Order.Prop_ShipPostalCode);
				}
			}
		}

		[Property("ShipCountry", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 15), ValidateLength(1, 15)]
		public string ShipCountry
		{
			get { return _shipCountry; }
			set
			{
				if ((_shipCountry == null) || (value == null) || (!value.Equals(_shipCountry)))
				{
					_shipCountry = value;
					NotifyPropertyChanged(Order.Prop_ShipCountry);
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

	} // Order
}

