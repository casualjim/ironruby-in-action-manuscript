namespace DataAccess.ActiveRecord
{
	// Business class Customer generated from Customers
	// Ivan Porto Carrero [2008-02-13] Created

	using System;
	using System.ComponentModel;
	using Castle.ActiveRecord;
    using Castle.Components.Validator;

	[ActiveRecord("Customers")]
	public partial class Customer 
		: ActiveRecordValidationBase<Customer> 
		, INotifyPropertyChanged
	{

		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_CustomerID = "CustomerID";
		public static string Prop_CompanyName = "CompanyName";
		public static string Prop_ContactName = "ContactName";
		public static string Prop_ContactTitle = "ContactTitle";
		public static string Prop_Address = "Address";
		public static string Prop_City = "City";
		public static string Prop_Region = "Region";
		public static string Prop_PostalCode = "PostalCode";
		public static string Prop_Country = "Country";
		public static string Prop_Phone = "Phone";
		public static string Prop_Fax = "Fax";

		#endregion

		#region Private_Variables

		private int _id;
		private string _customerID;
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


		#endregion

		#region Constructors

		public Customer()
		{
		}

		public Customer(
			int p_id,
			string p_customerID,
			string p_companyName,
			string p_contactName,
			string p_contactTitle,
			string p_address,
			string p_city,
			string p_region,
			string p_postalCode,
			string p_country,
			string p_phone,
			string p_fax)
		{
			_id = p_id;
			_customerID = p_customerID;
			_companyName = p_companyName;
			_contactName = p_contactName;
			_contactTitle = p_contactTitle;
			_address = p_address;
			_city = p_city;
			_region = p_region;
			_postalCode = p_postalCode;
			_country = p_country;
			_phone = p_phone;
			_fax = p_fax;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public int Id
		{
			get { return _id; }
		}

		[Property("CustomerID", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 5), ValidateLength(1, 5)]
		public string CustomerID
		{
			get { return _customerID; }
			set
			{
				if ((_customerID == null) || (value == null) || (!value.Equals(_customerID)))
				{
					_customerID = value;
					NotifyPropertyChanged(Customer.Prop_CustomerID);
				}
			}
		}

		[Property("CompanyName", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 40), ValidateLength(1, 40)]
		public string CompanyName
		{
			get { return _companyName; }
			set
			{
				if ((_companyName == null) || (value == null) || (!value.Equals(_companyName)))
				{
					_companyName = value;
					NotifyPropertyChanged(Customer.Prop_CompanyName);
				}
			}
		}

		[Property("ContactName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 30), ValidateLength(1, 30)]
		public string ContactName
		{
			get { return _contactName; }
			set
			{
				if ((_contactName == null) || (value == null) || (!value.Equals(_contactName)))
				{
					_contactName = value;
					NotifyPropertyChanged(Customer.Prop_ContactName);
				}
			}
		}

		[Property("ContactTitle", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 30), ValidateLength(1, 30)]
		public string ContactTitle
		{
			get { return _contactTitle; }
			set
			{
				if ((_contactTitle == null) || (value == null) || (!value.Equals(_contactTitle)))
				{
					_contactTitle = value;
					NotifyPropertyChanged(Customer.Prop_ContactTitle);
				}
			}
		}

		[Property("Address", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 60), ValidateLength(1, 60)]
		public string Address
		{
			get { return _address; }
			set
			{
				if ((_address == null) || (value == null) || (!value.Equals(_address)))
				{
					_address = value;
					NotifyPropertyChanged(Customer.Prop_Address);
				}
			}
		}

		[Property("City", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 15), ValidateLength(1, 15)]
		public string City
		{
			get { return _city; }
			set
			{
				if ((_city == null) || (value == null) || (!value.Equals(_city)))
				{
					_city = value;
					NotifyPropertyChanged(Customer.Prop_City);
				}
			}
		}

		[Property("Region", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 15), ValidateLength(1, 15)]
		public string Region
		{
			get { return _region; }
			set
			{
				if ((_region == null) || (value == null) || (!value.Equals(_region)))
				{
					_region = value;
					NotifyPropertyChanged(Customer.Prop_Region);
				}
			}
		}

		[Property("PostalCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10), ValidateLength(1, 10)]
		public string PostalCode
		{
			get { return _postalCode; }
			set
			{
				if ((_postalCode == null) || (value == null) || (!value.Equals(_postalCode)))
				{
					_postalCode = value;
					NotifyPropertyChanged(Customer.Prop_PostalCode);
				}
			}
		}

		[Property("Country", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 15), ValidateLength(1, 15)]
		public string Country
		{
			get { return _country; }
			set
			{
				if ((_country == null) || (value == null) || (!value.Equals(_country)))
				{
					_country = value;
					NotifyPropertyChanged(Customer.Prop_Country);
				}
			}
		}

		[Property("Phone", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 24), ValidateLength(1, 24)]
		public string Phone
		{
			get { return _phone; }
			set
			{
				if ((_phone == null) || (value == null) || (!value.Equals(_phone)))
				{
					_phone = value;
					NotifyPropertyChanged(Customer.Prop_Phone);
				}
			}
		}

		[Property("Fax", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 24), ValidateLength(1, 24)]
		public string Fax
		{
			get { return _fax; }
			set
			{
				if ((_fax == null) || (value == null) || (!value.Equals(_fax)))
				{
					_fax = value;
					NotifyPropertyChanged(Customer.Prop_Fax);
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

	} // Customer
}

