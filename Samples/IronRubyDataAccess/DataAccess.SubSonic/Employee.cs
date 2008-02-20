using System; 
using System.Text; 
using System.Data;
using System.Data.SqlClient;
using System.Data.Common;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration; 
using System.Xml; 
using System.Xml.Serialization;
using SubSonic; 
using SubSonic.Utilities;

namespace DataAccess.SubSonic
{
	/// <summary>
	/// Strongly-typed collection for the Employee class.
	/// </summary>
	[Serializable]
	public partial class EmployeeCollection : ActiveList<Employee, EmployeeCollection> 
	{	   
		public EmployeeCollection() {}

	}

	/// <summary>
	/// This is an ActiveRecord class which wraps the Employees table.
	/// </summary>
	[Serializable]
	public partial class Employee : ActiveRecord<Employee>
	{
		#region .ctors and Default Settings
		
		public Employee()
		{
		  SetSQLProps();
		  InitSetDefaults();
		  MarkNew();
		}

		
		private void InitSetDefaults() { SetDefaults(); }

		
		public Employee(bool useDatabaseDefaults)
		{
			SetSQLProps();
			if(useDatabaseDefaults)
				ForceDefaults();
			MarkNew();
		}

		public Employee(object keyID)
		{
			SetSQLProps();
			InitSetDefaults();
			LoadByKey(keyID);
		}

		 
		public Employee(string columnName, object columnValue)
		{
			SetSQLProps();
			InitSetDefaults();
			LoadByParam(columnName,columnValue);
		}

		
		protected static void SetSQLProps() { GetTableSchema(); }

		
		#endregion
		
		#region Schema and Query Accessor
		public static Query CreateQuery() { return new Query(Schema); }

		
		public static TableSchema.Table Schema
		{
			get
			{
				if (BaseSchema == null)
					SetSQLProps();
				return BaseSchema;
			}

		}

		
		private static void GetTableSchema() 
		{
			if(!IsSchemaInitialized)
			{
				//Schema declaration
				TableSchema.Table schema = new TableSchema.Table("Employees", TableType.Table, DataService.GetInstance("Northwind"));
				schema.Columns = new TableSchema.TableColumnCollection();
				schema.SchemaName = @"dbo";
				//columns
				
				TableSchema.TableColumn colvarId = new TableSchema.TableColumn(schema);
				colvarId.ColumnName = "Id";
				colvarId.DataType = DbType.Int32;
				colvarId.MaxLength = 0;
				colvarId.AutoIncrement = true;
				colvarId.IsNullable = false;
				colvarId.IsPrimaryKey = true;
				colvarId.IsForeignKey = false;
				colvarId.IsReadOnly = false;
				colvarId.DefaultSetting = @"";
				colvarId.ForeignKeyTableName = "";
				schema.Columns.Add(colvarId);
				
				TableSchema.TableColumn colvarLastName = new TableSchema.TableColumn(schema);
				colvarLastName.ColumnName = "LastName";
				colvarLastName.DataType = DbType.String;
				colvarLastName.MaxLength = 20;
				colvarLastName.AutoIncrement = false;
				colvarLastName.IsNullable = false;
				colvarLastName.IsPrimaryKey = false;
				colvarLastName.IsForeignKey = false;
				colvarLastName.IsReadOnly = false;
				colvarLastName.DefaultSetting = @"";
				colvarLastName.ForeignKeyTableName = "";
				schema.Columns.Add(colvarLastName);
				
				TableSchema.TableColumn colvarFirstName = new TableSchema.TableColumn(schema);
				colvarFirstName.ColumnName = "FirstName";
				colvarFirstName.DataType = DbType.String;
				colvarFirstName.MaxLength = 10;
				colvarFirstName.AutoIncrement = false;
				colvarFirstName.IsNullable = false;
				colvarFirstName.IsPrimaryKey = false;
				colvarFirstName.IsForeignKey = false;
				colvarFirstName.IsReadOnly = false;
				colvarFirstName.DefaultSetting = @"";
				colvarFirstName.ForeignKeyTableName = "";
				schema.Columns.Add(colvarFirstName);
				
				TableSchema.TableColumn colvarTitle = new TableSchema.TableColumn(schema);
				colvarTitle.ColumnName = "Title";
				colvarTitle.DataType = DbType.String;
				colvarTitle.MaxLength = 30;
				colvarTitle.AutoIncrement = false;
				colvarTitle.IsNullable = true;
				colvarTitle.IsPrimaryKey = false;
				colvarTitle.IsForeignKey = false;
				colvarTitle.IsReadOnly = false;
				colvarTitle.DefaultSetting = @"";
				colvarTitle.ForeignKeyTableName = "";
				schema.Columns.Add(colvarTitle);
				
				TableSchema.TableColumn colvarTitleOfCourtesy = new TableSchema.TableColumn(schema);
				colvarTitleOfCourtesy.ColumnName = "TitleOfCourtesy";
				colvarTitleOfCourtesy.DataType = DbType.String;
				colvarTitleOfCourtesy.MaxLength = 25;
				colvarTitleOfCourtesy.AutoIncrement = false;
				colvarTitleOfCourtesy.IsNullable = true;
				colvarTitleOfCourtesy.IsPrimaryKey = false;
				colvarTitleOfCourtesy.IsForeignKey = false;
				colvarTitleOfCourtesy.IsReadOnly = false;
				colvarTitleOfCourtesy.DefaultSetting = @"";
				colvarTitleOfCourtesy.ForeignKeyTableName = "";
				schema.Columns.Add(colvarTitleOfCourtesy);
				
				TableSchema.TableColumn colvarBirthDate = new TableSchema.TableColumn(schema);
				colvarBirthDate.ColumnName = "BirthDate";
				colvarBirthDate.DataType = DbType.DateTime;
				colvarBirthDate.MaxLength = 0;
				colvarBirthDate.AutoIncrement = false;
				colvarBirthDate.IsNullable = true;
				colvarBirthDate.IsPrimaryKey = false;
				colvarBirthDate.IsForeignKey = false;
				colvarBirthDate.IsReadOnly = false;
				colvarBirthDate.DefaultSetting = @"";
				colvarBirthDate.ForeignKeyTableName = "";
				schema.Columns.Add(colvarBirthDate);
				
				TableSchema.TableColumn colvarHireDate = new TableSchema.TableColumn(schema);
				colvarHireDate.ColumnName = "HireDate";
				colvarHireDate.DataType = DbType.DateTime;
				colvarHireDate.MaxLength = 0;
				colvarHireDate.AutoIncrement = false;
				colvarHireDate.IsNullable = true;
				colvarHireDate.IsPrimaryKey = false;
				colvarHireDate.IsForeignKey = false;
				colvarHireDate.IsReadOnly = false;
				colvarHireDate.DefaultSetting = @"";
				colvarHireDate.ForeignKeyTableName = "";
				schema.Columns.Add(colvarHireDate);
				
				TableSchema.TableColumn colvarAddress = new TableSchema.TableColumn(schema);
				colvarAddress.ColumnName = "Address";
				colvarAddress.DataType = DbType.String;
				colvarAddress.MaxLength = 60;
				colvarAddress.AutoIncrement = false;
				colvarAddress.IsNullable = true;
				colvarAddress.IsPrimaryKey = false;
				colvarAddress.IsForeignKey = false;
				colvarAddress.IsReadOnly = false;
				colvarAddress.DefaultSetting = @"";
				colvarAddress.ForeignKeyTableName = "";
				schema.Columns.Add(colvarAddress);
				
				TableSchema.TableColumn colvarCity = new TableSchema.TableColumn(schema);
				colvarCity.ColumnName = "City";
				colvarCity.DataType = DbType.String;
				colvarCity.MaxLength = 15;
				colvarCity.AutoIncrement = false;
				colvarCity.IsNullable = true;
				colvarCity.IsPrimaryKey = false;
				colvarCity.IsForeignKey = false;
				colvarCity.IsReadOnly = false;
				colvarCity.DefaultSetting = @"";
				colvarCity.ForeignKeyTableName = "";
				schema.Columns.Add(colvarCity);
				
				TableSchema.TableColumn colvarRegion = new TableSchema.TableColumn(schema);
				colvarRegion.ColumnName = "Region";
				colvarRegion.DataType = DbType.String;
				colvarRegion.MaxLength = 15;
				colvarRegion.AutoIncrement = false;
				colvarRegion.IsNullable = true;
				colvarRegion.IsPrimaryKey = false;
				colvarRegion.IsForeignKey = false;
				colvarRegion.IsReadOnly = false;
				colvarRegion.DefaultSetting = @"";
				colvarRegion.ForeignKeyTableName = "";
				schema.Columns.Add(colvarRegion);
				
				TableSchema.TableColumn colvarPostalCode = new TableSchema.TableColumn(schema);
				colvarPostalCode.ColumnName = "PostalCode";
				colvarPostalCode.DataType = DbType.String;
				colvarPostalCode.MaxLength = 10;
				colvarPostalCode.AutoIncrement = false;
				colvarPostalCode.IsNullable = true;
				colvarPostalCode.IsPrimaryKey = false;
				colvarPostalCode.IsForeignKey = false;
				colvarPostalCode.IsReadOnly = false;
				colvarPostalCode.DefaultSetting = @"";
				colvarPostalCode.ForeignKeyTableName = "";
				schema.Columns.Add(colvarPostalCode);
				
				TableSchema.TableColumn colvarCountry = new TableSchema.TableColumn(schema);
				colvarCountry.ColumnName = "Country";
				colvarCountry.DataType = DbType.String;
				colvarCountry.MaxLength = 15;
				colvarCountry.AutoIncrement = false;
				colvarCountry.IsNullable = true;
				colvarCountry.IsPrimaryKey = false;
				colvarCountry.IsForeignKey = false;
				colvarCountry.IsReadOnly = false;
				colvarCountry.DefaultSetting = @"";
				colvarCountry.ForeignKeyTableName = "";
				schema.Columns.Add(colvarCountry);
				
				TableSchema.TableColumn colvarHomePhone = new TableSchema.TableColumn(schema);
				colvarHomePhone.ColumnName = "HomePhone";
				colvarHomePhone.DataType = DbType.String;
				colvarHomePhone.MaxLength = 24;
				colvarHomePhone.AutoIncrement = false;
				colvarHomePhone.IsNullable = true;
				colvarHomePhone.IsPrimaryKey = false;
				colvarHomePhone.IsForeignKey = false;
				colvarHomePhone.IsReadOnly = false;
				colvarHomePhone.DefaultSetting = @"";
				colvarHomePhone.ForeignKeyTableName = "";
				schema.Columns.Add(colvarHomePhone);
				
				TableSchema.TableColumn colvarExtension = new TableSchema.TableColumn(schema);
				colvarExtension.ColumnName = "Extension";
				colvarExtension.DataType = DbType.String;
				colvarExtension.MaxLength = 4;
				colvarExtension.AutoIncrement = false;
				colvarExtension.IsNullable = true;
				colvarExtension.IsPrimaryKey = false;
				colvarExtension.IsForeignKey = false;
				colvarExtension.IsReadOnly = false;
				colvarExtension.DefaultSetting = @"";
				colvarExtension.ForeignKeyTableName = "";
				schema.Columns.Add(colvarExtension);
				
				TableSchema.TableColumn colvarPhoto = new TableSchema.TableColumn(schema);
				colvarPhoto.ColumnName = "Photo";
				colvarPhoto.DataType = DbType.Binary;
				colvarPhoto.MaxLength = 2147483647;
				colvarPhoto.AutoIncrement = false;
				colvarPhoto.IsNullable = true;
				colvarPhoto.IsPrimaryKey = false;
				colvarPhoto.IsForeignKey = false;
				colvarPhoto.IsReadOnly = false;
				colvarPhoto.DefaultSetting = @"";
				colvarPhoto.ForeignKeyTableName = "";
				schema.Columns.Add(colvarPhoto);
				
				TableSchema.TableColumn colvarNotes = new TableSchema.TableColumn(schema);
				colvarNotes.ColumnName = "Notes";
				colvarNotes.DataType = DbType.String;
				colvarNotes.MaxLength = 1073741823;
				colvarNotes.AutoIncrement = false;
				colvarNotes.IsNullable = true;
				colvarNotes.IsPrimaryKey = false;
				colvarNotes.IsForeignKey = false;
				colvarNotes.IsReadOnly = false;
				colvarNotes.DefaultSetting = @"";
				colvarNotes.ForeignKeyTableName = "";
				schema.Columns.Add(colvarNotes);
				
				TableSchema.TableColumn colvarReportsToId = new TableSchema.TableColumn(schema);
				colvarReportsToId.ColumnName = "ReportsToId";
				colvarReportsToId.DataType = DbType.Int32;
				colvarReportsToId.MaxLength = 0;
				colvarReportsToId.AutoIncrement = false;
				colvarReportsToId.IsNullable = true;
				colvarReportsToId.IsPrimaryKey = false;
				colvarReportsToId.IsForeignKey = false;
				colvarReportsToId.IsReadOnly = false;
				colvarReportsToId.DefaultSetting = @"";
				colvarReportsToId.ForeignKeyTableName = "";
				schema.Columns.Add(colvarReportsToId);
				
				TableSchema.TableColumn colvarPhotoPath = new TableSchema.TableColumn(schema);
				colvarPhotoPath.ColumnName = "PhotoPath";
				colvarPhotoPath.DataType = DbType.String;
				colvarPhotoPath.MaxLength = 255;
				colvarPhotoPath.AutoIncrement = false;
				colvarPhotoPath.IsNullable = true;
				colvarPhotoPath.IsPrimaryKey = false;
				colvarPhotoPath.IsForeignKey = false;
				colvarPhotoPath.IsReadOnly = false;
				colvarPhotoPath.DefaultSetting = @"";
				colvarPhotoPath.ForeignKeyTableName = "";
				schema.Columns.Add(colvarPhotoPath);
				
				BaseSchema = schema;
				//add this schema to the provider
				//so we can query it later
				DataService.Providers["Northwind"].AddSchema("Employees",schema);
			}

		}

		#endregion
		
		#region Props
		
		  
		[XmlAttribute("Id")]
		public int Id 
		{
			get { return GetColumnValue<int>("Id"); }

			set { SetColumnValue("Id", value); }

		}

		  
		[XmlAttribute("LastName")]
		public string LastName 
		{
			get { return GetColumnValue<string>("LastName"); }

			set { SetColumnValue("LastName", value); }

		}

		  
		[XmlAttribute("FirstName")]
		public string FirstName 
		{
			get { return GetColumnValue<string>("FirstName"); }

			set { SetColumnValue("FirstName", value); }

		}

		  
		[XmlAttribute("Title")]
		public string Title 
		{
			get { return GetColumnValue<string>("Title"); }

			set { SetColumnValue("Title", value); }

		}

		  
		[XmlAttribute("TitleOfCourtesy")]
		public string TitleOfCourtesy 
		{
			get { return GetColumnValue<string>("TitleOfCourtesy"); }

			set { SetColumnValue("TitleOfCourtesy", value); }

		}

		  
		[XmlAttribute("BirthDate")]
		public DateTime? BirthDate 
		{
			get { return GetColumnValue<DateTime?>("BirthDate"); }

			set { SetColumnValue("BirthDate", value); }

		}

		  
		[XmlAttribute("HireDate")]
		public DateTime? HireDate 
		{
			get { return GetColumnValue<DateTime?>("HireDate"); }

			set { SetColumnValue("HireDate", value); }

		}

		  
		[XmlAttribute("Address")]
		public string Address 
		{
			get { return GetColumnValue<string>("Address"); }

			set { SetColumnValue("Address", value); }

		}

		  
		[XmlAttribute("City")]
		public string City 
		{
			get { return GetColumnValue<string>("City"); }

			set { SetColumnValue("City", value); }

		}

		  
		[XmlAttribute("Region")]
		public string Region 
		{
			get { return GetColumnValue<string>("Region"); }

			set { SetColumnValue("Region", value); }

		}

		  
		[XmlAttribute("PostalCode")]
		public string PostalCode 
		{
			get { return GetColumnValue<string>("PostalCode"); }

			set { SetColumnValue("PostalCode", value); }

		}

		  
		[XmlAttribute("Country")]
		public string Country 
		{
			get { return GetColumnValue<string>("Country"); }

			set { SetColumnValue("Country", value); }

		}

		  
		[XmlAttribute("HomePhone")]
		public string HomePhone 
		{
			get { return GetColumnValue<string>("HomePhone"); }

			set { SetColumnValue("HomePhone", value); }

		}

		  
		[XmlAttribute("Extension")]
		public string Extension 
		{
			get { return GetColumnValue<string>("Extension"); }

			set { SetColumnValue("Extension", value); }

		}

		  
		[XmlAttribute("Photo")]
		public byte[] Photo 
		{
			get { return GetColumnValue<byte[]>("Photo"); }

			set { SetColumnValue("Photo", value); }

		}

		  
		[XmlAttribute("Notes")]
		public string Notes 
		{
			get { return GetColumnValue<string>("Notes"); }

			set { SetColumnValue("Notes", value); }

		}

		  
		[XmlAttribute("ReportsToId")]
		public int? ReportsToId 
		{
			get { return GetColumnValue<int?>("ReportsToId"); }

			set { SetColumnValue("ReportsToId", value); }

		}

		  
		[XmlAttribute("PhotoPath")]
		public string PhotoPath 
		{
			get { return GetColumnValue<string>("PhotoPath"); }

			set { SetColumnValue("PhotoPath", value); }

		}

		
		#endregion
		
		
			
		
		//no foreign key tables defined (0)
		
		
		
		//no ManyToMany tables defined (0)
		
		#region ObjectDataSource support
		
		
		/// <summary>
		/// Inserts a record, can be used with the Object Data Source
		/// </summary>
		public static void Insert(string varLastName,string varFirstName,string varTitle,string varTitleOfCourtesy,DateTime? varBirthDate,DateTime? varHireDate,string varAddress,string varCity,string varRegion,string varPostalCode,string varCountry,string varHomePhone,string varExtension,byte[] varPhoto,string varNotes,int? varReportsToId,string varPhotoPath)
		{
			Employee item = new Employee();
			
			item.LastName = varLastName;
			
			item.FirstName = varFirstName;
			
			item.Title = varTitle;
			
			item.TitleOfCourtesy = varTitleOfCourtesy;
			
			item.BirthDate = varBirthDate;
			
			item.HireDate = varHireDate;
			
			item.Address = varAddress;
			
			item.City = varCity;
			
			item.Region = varRegion;
			
			item.PostalCode = varPostalCode;
			
			item.Country = varCountry;
			
			item.HomePhone = varHomePhone;
			
			item.Extension = varExtension;
			
			item.Photo = varPhoto;
			
			item.Notes = varNotes;
			
			item.ReportsToId = varReportsToId;
			
			item.PhotoPath = varPhotoPath;
			
		
			if (System.Web.HttpContext.Current != null)
				item.Save(System.Web.HttpContext.Current.User.Identity.Name);
			else
				item.Save(System.Threading.Thread.CurrentPrincipal.Identity.Name);
		}

		
		/// <summary>
		/// Updates a record, can be used with the Object Data Source
		/// </summary>
		public static void Update(int varId,string varLastName,string varFirstName,string varTitle,string varTitleOfCourtesy,DateTime? varBirthDate,DateTime? varHireDate,string varAddress,string varCity,string varRegion,string varPostalCode,string varCountry,string varHomePhone,string varExtension,byte[] varPhoto,string varNotes,int? varReportsToId,string varPhotoPath)
		{
			Employee item = new Employee();
			
				item.Id = varId;
				
				item.LastName = varLastName;
				
				item.FirstName = varFirstName;
				
				item.Title = varTitle;
				
				item.TitleOfCourtesy = varTitleOfCourtesy;
				
				item.BirthDate = varBirthDate;
				
				item.HireDate = varHireDate;
				
				item.Address = varAddress;
				
				item.City = varCity;
				
				item.Region = varRegion;
				
				item.PostalCode = varPostalCode;
				
				item.Country = varCountry;
				
				item.HomePhone = varHomePhone;
				
				item.Extension = varExtension;
				
				item.Photo = varPhoto;
				
				item.Notes = varNotes;
				
				item.ReportsToId = varReportsToId;
				
				item.PhotoPath = varPhotoPath;
				
			item.IsNew = false;
			if (System.Web.HttpContext.Current != null)
				item.Save(System.Web.HttpContext.Current.User.Identity.Name);
			else
				item.Save(System.Threading.Thread.CurrentPrincipal.Identity.Name);
		}

		#endregion
		#region Columns Struct
		public struct Columns
		{
			 public static string Id = @"Id";
			 public static string LastName = @"LastName";
			 public static string FirstName = @"FirstName";
			 public static string Title = @"Title";
			 public static string TitleOfCourtesy = @"TitleOfCourtesy";
			 public static string BirthDate = @"BirthDate";
			 public static string HireDate = @"HireDate";
			 public static string Address = @"Address";
			 public static string City = @"City";
			 public static string Region = @"Region";
			 public static string PostalCode = @"PostalCode";
			 public static string Country = @"Country";
			 public static string HomePhone = @"HomePhone";
			 public static string Extension = @"Extension";
			 public static string Photo = @"Photo";
			 public static string Notes = @"Notes";
			 public static string ReportsToId = @"ReportsToId";
			 public static string PhotoPath = @"PhotoPath";
						
		}

		#endregion
	}

}

