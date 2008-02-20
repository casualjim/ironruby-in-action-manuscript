namespace DataAccess.ActiveRecord
{
	// Business class Shipper generated from Shippers
	// Ivan Porto Carrero [2008-02-13] Created

	using System;
	using System.ComponentModel;
	using Castle.ActiveRecord;
    using Castle.Components.Validator;

	[ActiveRecord("Shippers")]
	public partial class Shipper 
		: ActiveRecordValidationBase<Shipper> 
		, INotifyPropertyChanged
	{

		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_CompanyName = "CompanyName";
		public static string Prop_Phone = "Phone";

		#endregion

		#region Private_Variables

		private int _id;
		private string _companyName;
		private string _phone;


		#endregion

		#region Constructors

		public Shipper()
		{
		}

		public Shipper(
			int p_id,
			string p_companyName,
			string p_phone)
		{
			_id = p_id;
			_companyName = p_companyName;
			_phone = p_phone;
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
					NotifyPropertyChanged(Shipper.Prop_CompanyName);
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
					NotifyPropertyChanged(Shipper.Prop_Phone);
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

	} // Shipper
}

