namespace DataAccess.ActiveRecord
{
	// Business class Employee generated from Employees
	// Ivan Porto Carrero [2008-02-13] Created

	using System;
	using System.ComponentModel;
	using Castle.ActiveRecord;
    using Castle.Components.Validator;

	[ActiveRecord("Employees")]
	public partial class Employee 
		: ActiveRecordValidationBase<Employee> 
		, INotifyPropertyChanged
	{

		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_LastName = "LastName";
		public static string Prop_FirstName = "FirstName";
		public static string Prop_Title = "Title";
		public static string Prop_TitleOfCourtesy = "TitleOfCourtesy";
		public static string Prop_BirthDate = "BirthDate";
		public static string Prop_HireDate = "HireDate";
		public static string Prop_Address = "Address";
		public static string Prop_City = "City";
		public static string Prop_Region = "Region";
		public static string Prop_PostalCode = "PostalCode";
		public static string Prop_Country = "Country";
		public static string Prop_HomePhone = "HomePhone";
		public static string Prop_Extension = "Extension";
		public static string Prop_Photo = "Photo";
		public static string Prop_Notes = "Notes";
		public static string Prop_ReportsToId = "ReportsToId";
		public static string Prop_PhotoPath = "PhotoPath";

		#endregion

		#region Private_Variables

		private int _id;
		private string _lastName;
		private string _firstName;
		private string _title;
		private string _titleOfCourtesy;
		private DateTime? _birthDate;
		private DateTime? _hireDate;
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


		#endregion

		#region Constructors

		public Employee()
		{
		}

		public Employee(
			int p_id,
			string p_lastName,
			string p_firstName,
			string p_title,
			string p_titleOfCourtesy,
			DateTime? p_birthDate,
			DateTime? p_hireDate,
			string p_address,
			string p_city,
			string p_region,
			string p_postalCode,
			string p_country,
			string p_homePhone,
			string p_extension,
			byte[] p_photo,
			string p_notes,
			int? p_reportsToId,
			string p_photoPath)
		{
			_id = p_id;
			_lastName = p_lastName;
			_firstName = p_firstName;
			_title = p_title;
			_titleOfCourtesy = p_titleOfCourtesy;
			_birthDate = p_birthDate;
			_hireDate = p_hireDate;
			_address = p_address;
			_city = p_city;
			_region = p_region;
			_postalCode = p_postalCode;
			_country = p_country;
			_homePhone = p_homePhone;
			_extension = p_extension;
			_photo = p_photo;
			_notes = p_notes;
			_reportsToId = p_reportsToId;
			_photoPath = p_photoPath;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public int Id
		{
			get { return _id; }
		}

		[Property("LastName", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 20), ValidateLength(1, 20)]
		public string LastName
		{
			get { return _lastName; }
			set
			{
				if ((_lastName == null) || (value == null) || (!value.Equals(_lastName)))
				{
					_lastName = value;
					NotifyPropertyChanged(Employee.Prop_LastName);
				}
			}
		}

		[Property("FirstName", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 10), ValidateLength(1, 10)]
		public string FirstName
		{
			get { return _firstName; }
			set
			{
				if ((_firstName == null) || (value == null) || (!value.Equals(_firstName)))
				{
					_firstName = value;
					NotifyPropertyChanged(Employee.Prop_FirstName);
				}
			}
		}

		[Property("Title", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 30), ValidateLength(1, 30)]
		public string Title
		{
			get { return _title; }
			set
			{
				if ((_title == null) || (value == null) || (!value.Equals(_title)))
				{
					_title = value;
					NotifyPropertyChanged(Employee.Prop_Title);
				}
			}
		}

		[Property("TitleOfCourtesy", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 25), ValidateLength(1, 25)]
		public string TitleOfCourtesy
		{
			get { return _titleOfCourtesy; }
			set
			{
				if ((_titleOfCourtesy == null) || (value == null) || (!value.Equals(_titleOfCourtesy)))
				{
					_titleOfCourtesy = value;
					NotifyPropertyChanged(Employee.Prop_TitleOfCourtesy);
				}
			}
		}

		[Property("BirthDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? BirthDate
		{
			get { return _birthDate; }
			set
			{
				if (value != _birthDate)
				{
					_birthDate = value;
					NotifyPropertyChanged(Employee.Prop_BirthDate);
				}
			}
		}

		[Property("HireDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? HireDate
		{
			get { return _hireDate; }
			set
			{
				if (value != _hireDate)
				{
					_hireDate = value;
					NotifyPropertyChanged(Employee.Prop_HireDate);
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
					NotifyPropertyChanged(Employee.Prop_Address);
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
					NotifyPropertyChanged(Employee.Prop_City);
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
					NotifyPropertyChanged(Employee.Prop_Region);
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
					NotifyPropertyChanged(Employee.Prop_PostalCode);
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
					NotifyPropertyChanged(Employee.Prop_Country);
				}
			}
		}

		[Property("HomePhone", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 24), ValidateLength(1, 24)]
		public string HomePhone
		{
			get { return _homePhone; }
			set
			{
				if ((_homePhone == null) || (value == null) || (!value.Equals(_homePhone)))
				{
					_homePhone = value;
					NotifyPropertyChanged(Employee.Prop_HomePhone);
				}
			}
		}

		[Property("Extension", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 4), ValidateLength(1, 4)]
		public string Extension
		{
			get { return _extension; }
			set
			{
				if ((_extension == null) || (value == null) || (!value.Equals(_extension)))
				{
					_extension = value;
					NotifyPropertyChanged(Employee.Prop_Extension);
				}
			}
		}

		[Property("Photo", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public byte[] Photo
		{
			get { return _photo; }
			set
			{
				if (value != _photo)
				{
					_photo = value;
					NotifyPropertyChanged(Employee.Prop_Photo);
				}
			}
		}

		[Property("Notes", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string Notes
		{
			get { return _notes; }
			set
			{
				if ((_notes == null) || (value == null) || (!value.Equals(_notes)))
				{
					_notes = value;
					NotifyPropertyChanged(Employee.Prop_Notes);
				}
			}
		}

		[Property("ReportsToId", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? ReportsToId
		{
			get { return _reportsToId; }
			set
			{
				if (value != _reportsToId)
				{
					_reportsToId = value;
					NotifyPropertyChanged(Employee.Prop_ReportsToId);
				}
			}
		}

		[Property("PhotoPath", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 255), ValidateLength(1, 255)]
		public string PhotoPath
		{
			get { return _photoPath; }
			set
			{
				if ((_photoPath == null) || (value == null) || (!value.Equals(_photoPath)))
				{
					_photoPath = value;
					NotifyPropertyChanged(Employee.Prop_PhotoPath);
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

	} // Employee
}

