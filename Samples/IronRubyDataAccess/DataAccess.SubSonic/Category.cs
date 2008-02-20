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
	/// Strongly-typed collection for the Category class.
	/// </summary>
	[Serializable]
	public partial class CategoryCollection : ActiveList<Category, CategoryCollection> 
	{	   
		public CategoryCollection() {}

	}

	/// <summary>
	/// This is an ActiveRecord class which wraps the Categories table.
	/// </summary>
	[Serializable]
	public partial class Category : ActiveRecord<Category>
	{
		#region .ctors and Default Settings
		
		public Category()
		{
		  SetSQLProps();
		  InitSetDefaults();
		  MarkNew();
		}

		
		private void InitSetDefaults() { SetDefaults(); }

		
		public Category(bool useDatabaseDefaults)
		{
			SetSQLProps();
			if(useDatabaseDefaults)
				ForceDefaults();
			MarkNew();
		}

		public Category(object keyID)
		{
			SetSQLProps();
			InitSetDefaults();
			LoadByKey(keyID);
		}

		 
		public Category(string columnName, object columnValue)
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
				TableSchema.Table schema = new TableSchema.Table("Categories", TableType.Table, DataService.GetInstance("Northwind"));
				schema.Columns = new TableSchema.TableColumnCollection();
				schema.SchemaName = @"dbo";
				//columns
				
				TableSchema.TableColumn colvarId = new TableSchema.TableColumn(schema);
				colvarId.ColumnName = "Id";
				colvarId.DataType = DbType.Int32;
				colvarId.MaxLength = 0;
				colvarId.AutoIncrement = false;
				colvarId.IsNullable = false;
				colvarId.IsPrimaryKey = true;
				colvarId.IsForeignKey = false;
				colvarId.IsReadOnly = false;
				colvarId.DefaultSetting = @"";
				colvarId.ForeignKeyTableName = "";
				schema.Columns.Add(colvarId);
				
				TableSchema.TableColumn colvarCategoryName = new TableSchema.TableColumn(schema);
				colvarCategoryName.ColumnName = "CategoryName";
				colvarCategoryName.DataType = DbType.String;
				colvarCategoryName.MaxLength = 15;
				colvarCategoryName.AutoIncrement = false;
				colvarCategoryName.IsNullable = false;
				colvarCategoryName.IsPrimaryKey = false;
				colvarCategoryName.IsForeignKey = false;
				colvarCategoryName.IsReadOnly = false;
				colvarCategoryName.DefaultSetting = @"";
				colvarCategoryName.ForeignKeyTableName = "";
				schema.Columns.Add(colvarCategoryName);
				
				TableSchema.TableColumn colvarDescription = new TableSchema.TableColumn(schema);
				colvarDescription.ColumnName = "Description";
				colvarDescription.DataType = DbType.String;
				colvarDescription.MaxLength = 1073741823;
				colvarDescription.AutoIncrement = false;
				colvarDescription.IsNullable = true;
				colvarDescription.IsPrimaryKey = false;
				colvarDescription.IsForeignKey = false;
				colvarDescription.IsReadOnly = false;
				colvarDescription.DefaultSetting = @"";
				colvarDescription.ForeignKeyTableName = "";
				schema.Columns.Add(colvarDescription);
				
				TableSchema.TableColumn colvarPicture = new TableSchema.TableColumn(schema);
				colvarPicture.ColumnName = "Picture";
				colvarPicture.DataType = DbType.Binary;
				colvarPicture.MaxLength = 2147483647;
				colvarPicture.AutoIncrement = false;
				colvarPicture.IsNullable = true;
				colvarPicture.IsPrimaryKey = false;
				colvarPicture.IsForeignKey = false;
				colvarPicture.IsReadOnly = false;
				colvarPicture.DefaultSetting = @"";
				colvarPicture.ForeignKeyTableName = "";
				schema.Columns.Add(colvarPicture);
				
				BaseSchema = schema;
				//add this schema to the provider
				//so we can query it later
				DataService.Providers["Northwind"].AddSchema("Categories",schema);
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

		  
		[XmlAttribute("CategoryName")]
		public string CategoryName 
		{
			get { return GetColumnValue<string>("CategoryName"); }

			set { SetColumnValue("CategoryName", value); }

		}

		  
		[XmlAttribute("Description")]
		public string Description 
		{
			get { return GetColumnValue<string>("Description"); }

			set { SetColumnValue("Description", value); }

		}

		  
		[XmlAttribute("Picture")]
		public byte[] Picture 
		{
			get { return GetColumnValue<byte[]>("Picture"); }

			set { SetColumnValue("Picture", value); }

		}

		
		#endregion
		
		
		#region PrimaryKey Methods
		
		public ProductCollection Products()
		{
			return new ProductCollection().Where(Product.Columns.CategoryId, Id).Load();
		}

		#endregion
		
			
		
		//no foreign key tables defined (0)
		
		
		
		//no ManyToMany tables defined (0)
		
		#region ObjectDataSource support
		
		
		/// <summary>
		/// Inserts a record, can be used with the Object Data Source
		/// </summary>
		public static void Insert(int varId,string varCategoryName,string varDescription,byte[] varPicture)
		{
			Category item = new Category();
			
			item.Id = varId;
			
			item.CategoryName = varCategoryName;
			
			item.Description = varDescription;
			
			item.Picture = varPicture;
			
		
			if (System.Web.HttpContext.Current != null)
				item.Save(System.Web.HttpContext.Current.User.Identity.Name);
			else
				item.Save(System.Threading.Thread.CurrentPrincipal.Identity.Name);
		}

		
		/// <summary>
		/// Updates a record, can be used with the Object Data Source
		/// </summary>
		public static void Update(int varId,string varCategoryName,string varDescription,byte[] varPicture)
		{
			Category item = new Category();
			
				item.Id = varId;
				
				item.CategoryName = varCategoryName;
				
				item.Description = varDescription;
				
				item.Picture = varPicture;
				
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
			 public static string CategoryName = @"CategoryName";
			 public static string Description = @"Description";
			 public static string Picture = @"Picture";
						
		}

		#endregion
	}

}

