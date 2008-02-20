namespace DataAccess.ActiveRecord
{
	// Business class Category generated from Categories
	// Ivan Porto Carrero [2008-02-13] Created

	using System;
	using System.ComponentModel;
	using Castle.ActiveRecord;
    using System.Collections;
    using Castle.Components.Validator;
    using System.Collections.Generic;

	[ActiveRecord("Categories")]
	public class Category 
		: ActiveRecordValidationBase<Category> 
		, INotifyPropertyChanged
	{

		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_CategoryName = "CategoryName";
		public static string Prop_Description = "Description";
		public static string Prop_Picture = "Picture";

		#endregion

		#region Private_Variables

		private int _id;
		private string _categoryName;
		private string _description;
		private byte[] _picture;

		private IList _Products = new List<Product>();

		#endregion

		#region Constructors

		public Category()
		{
		}

		public Category(
			int p_id,
			string p_categoryName,
			string p_description,
			byte[] p_picture)
		{
			_id = p_id;
			_categoryName = p_categoryName;
			_description = p_description;
			_picture = p_picture;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public int Id
		{
			get { return _id; }
		}

		[Property("CategoryName", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 15), ValidateLength(1, 15)]
		public string CategoryName
		{
			get { return _categoryName; }
			set
			{
				if ((_categoryName == null) || (value == null) || (!value.Equals(_categoryName)))
				{
					_categoryName = value;
					NotifyPropertyChanged(Category.Prop_CategoryName);
				}
			}
		}

		[Property("Description", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string Description
		{
			get { return _description; }
			set
			{
				if ((_description == null) || (value == null) || (!value.Equals(_description)))
				{
					_description = value;
					NotifyPropertyChanged(Category.Prop_Description);
				}
			}
		}

		[Property("Picture", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public byte[] Picture
		{
			get { return _picture; }
			set
			{
				if (value != _picture)
				{
					_picture = value;
					NotifyPropertyChanged(Category.Prop_Picture);
				}
			}
		}

	[HasMany(typeof(Product), Table="Products", ColumnKey="CategoryId")]
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

	} // Category
}

