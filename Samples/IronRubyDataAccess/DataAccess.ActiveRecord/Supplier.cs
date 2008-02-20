namespace DataAccess.ActiveRecord
{
	// Business class Supplier generated from Suppliers
	// Ivan Porto Carrero [2008-02-13] Created

	using System;
	using System.ComponentModel;
	using Castle.ActiveRecord;
    using System.Collections;
    using Castle.Components.Validator;
    using System.Collections.Generic;

	[ActiveRecord("Suppliers")]
	public partial class Supplier 
		: ActiveRecordValidationBase<Supplier> 
		, INotifyPropertyChanged
	{

		#region Property_Names

		public static string Prop_Id = "Id";
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
		public static string Prop_HomePage = "HomePage";

		#endregion

		#region Private_Variables

		private int _id;
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

		private IList _Products = new List<Product>();

		#endregion

		#region Constructors

		public Supplier()
		{
		}

		public Supplier(
			int p_id,
			string p_companyName,
			string p_contactName,
			string p_contactTitle,
			string p_address,
			string p_city,
			string p_region,
			string p_postalCode,
			string p_country,
			string p_phone,
			string p_fax,
			string p_homePage)
		{
			_id = p_id;
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
			_homePage = p_homePage;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public int Id
		{
			get { return _id; }
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
					NotifyPropertyChanged(Supplier.Prop_CompanyName);
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
					NotifyPropertyChanged(Supplier.Prop_ContactName);
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
					NotifyPropertyChanged(Supplier.Prop_ContactTitle);
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
					NotifyPropertyChanged(Supplier.Prop_Address);
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
					NotifyPropertyChanged(Supplier.Prop_City);
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
					NotifyPropertyChanged(Supplier.Prop_Region);
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
					NotifyPropertyChanged(Supplier.Prop_PostalCode);
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
					NotifyPropertyChanged(Supplier.Prop_Country);
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
					NotifyPropertyChanged(Supplier.Prop_Phone);
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
					NotifyPropertyChanged(Supplier.Prop_Fax);
				}
			}
		}

		[Property("HomePage", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string HomePage
		{
			get { return _homePage; }
			set
			{
				if ((_homePage == null) || (value == null) || (!value.Equals(_homePage)))
				{
					_homePage = value;
					NotifyPropertyChanged(Supplier.Prop_HomePage);
				}
			}
		}

	[HasMany(typeof(Product), Table="Products", ColumnKey="SupplierId")]
	public IList Products
	{
	    get { return _Products; }
	    set { _Products = value; }
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

	} // Supplier
}

