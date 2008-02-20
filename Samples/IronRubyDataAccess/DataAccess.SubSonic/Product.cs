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
	/// Strongly-typed collection for the Product class.
	/// </summary>
	[Serializable]
	public partial class ProductCollection : ActiveList<Product, ProductCollection> 
	{	   
		public ProductCollection() {}

	}

	/// <summary>
	/// This is an ActiveRecord class which wraps the Products table.
	/// </summary>
	[Serializable]
	public partial class Product : ActiveRecord<Product>
	{
		#region .ctors and Default Settings
		
		public Product()
		{
		  SetSQLProps();
		  InitSetDefaults();
		  MarkNew();
		}

		
		private void InitSetDefaults() { SetDefaults(); }

		
		public Product(bool useDatabaseDefaults)
		{
			SetSQLProps();
			if(useDatabaseDefaults)
				ForceDefaults();
			MarkNew();
		}

		public Product(object keyID)
		{
			SetSQLProps();
			InitSetDefaults();
			LoadByKey(keyID);
		}

		 
		public Product(string columnName, object columnValue)
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
				TableSchema.Table schema = new TableSchema.Table("Products", TableType.Table, DataService.GetInstance("Northwind"));
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
				
				TableSchema.TableColumn colvarProductName = new TableSchema.TableColumn(schema);
				colvarProductName.ColumnName = "ProductName";
				colvarProductName.DataType = DbType.String;
				colvarProductName.MaxLength = 40;
				colvarProductName.AutoIncrement = false;
				colvarProductName.IsNullable = false;
				colvarProductName.IsPrimaryKey = false;
				colvarProductName.IsForeignKey = false;
				colvarProductName.IsReadOnly = false;
				colvarProductName.DefaultSetting = @"";
				colvarProductName.ForeignKeyTableName = "";
				schema.Columns.Add(colvarProductName);
				
				TableSchema.TableColumn colvarSupplierId = new TableSchema.TableColumn(schema);
				colvarSupplierId.ColumnName = "SupplierId";
				colvarSupplierId.DataType = DbType.Int32;
				colvarSupplierId.MaxLength = 0;
				colvarSupplierId.AutoIncrement = false;
				colvarSupplierId.IsNullable = true;
				colvarSupplierId.IsPrimaryKey = false;
				colvarSupplierId.IsForeignKey = true;
				colvarSupplierId.IsReadOnly = false;
				colvarSupplierId.DefaultSetting = @"";
				
					colvarSupplierId.ForeignKeyTableName = "Suppliers";
				schema.Columns.Add(colvarSupplierId);
				
				TableSchema.TableColumn colvarCategoryId = new TableSchema.TableColumn(schema);
				colvarCategoryId.ColumnName = "CategoryId";
				colvarCategoryId.DataType = DbType.Int32;
				colvarCategoryId.MaxLength = 0;
				colvarCategoryId.AutoIncrement = false;
				colvarCategoryId.IsNullable = true;
				colvarCategoryId.IsPrimaryKey = false;
				colvarCategoryId.IsForeignKey = true;
				colvarCategoryId.IsReadOnly = false;
				colvarCategoryId.DefaultSetting = @"";
				
					colvarCategoryId.ForeignKeyTableName = "Categories";
				schema.Columns.Add(colvarCategoryId);
				
				TableSchema.TableColumn colvarQuantityPerUnit = new TableSchema.TableColumn(schema);
				colvarQuantityPerUnit.ColumnName = "QuantityPerUnit";
				colvarQuantityPerUnit.DataType = DbType.String;
				colvarQuantityPerUnit.MaxLength = 20;
				colvarQuantityPerUnit.AutoIncrement = false;
				colvarQuantityPerUnit.IsNullable = true;
				colvarQuantityPerUnit.IsPrimaryKey = false;
				colvarQuantityPerUnit.IsForeignKey = false;
				colvarQuantityPerUnit.IsReadOnly = false;
				colvarQuantityPerUnit.DefaultSetting = @"";
				colvarQuantityPerUnit.ForeignKeyTableName = "";
				schema.Columns.Add(colvarQuantityPerUnit);
				
				TableSchema.TableColumn colvarUnitPrice = new TableSchema.TableColumn(schema);
				colvarUnitPrice.ColumnName = "UnitPrice";
				colvarUnitPrice.DataType = DbType.Currency;
				colvarUnitPrice.MaxLength = 0;
				colvarUnitPrice.AutoIncrement = false;
				colvarUnitPrice.IsNullable = true;
				colvarUnitPrice.IsPrimaryKey = false;
				colvarUnitPrice.IsForeignKey = false;
				colvarUnitPrice.IsReadOnly = false;
				
						colvarUnitPrice.DefaultSetting = @"((0))";
				colvarUnitPrice.ForeignKeyTableName = "";
				schema.Columns.Add(colvarUnitPrice);
				
				TableSchema.TableColumn colvarUnitsInStock = new TableSchema.TableColumn(schema);
				colvarUnitsInStock.ColumnName = "UnitsInStock";
				colvarUnitsInStock.DataType = DbType.Int32;
				colvarUnitsInStock.MaxLength = 0;
				colvarUnitsInStock.AutoIncrement = false;
				colvarUnitsInStock.IsNullable = true;
				colvarUnitsInStock.IsPrimaryKey = false;
				colvarUnitsInStock.IsForeignKey = false;
				colvarUnitsInStock.IsReadOnly = false;
				
						colvarUnitsInStock.DefaultSetting = @"((0))";
				colvarUnitsInStock.ForeignKeyTableName = "";
				schema.Columns.Add(colvarUnitsInStock);
				
				TableSchema.TableColumn colvarUnitsOnOrder = new TableSchema.TableColumn(schema);
				colvarUnitsOnOrder.ColumnName = "UnitsOnOrder";
				colvarUnitsOnOrder.DataType = DbType.Int32;
				colvarUnitsOnOrder.MaxLength = 0;
				colvarUnitsOnOrder.AutoIncrement = false;
				colvarUnitsOnOrder.IsNullable = true;
				colvarUnitsOnOrder.IsPrimaryKey = false;
				colvarUnitsOnOrder.IsForeignKey = false;
				colvarUnitsOnOrder.IsReadOnly = false;
				
						colvarUnitsOnOrder.DefaultSetting = @"((0))";
				colvarUnitsOnOrder.ForeignKeyTableName = "";
				schema.Columns.Add(colvarUnitsOnOrder);
				
				TableSchema.TableColumn colvarReorderLevel = new TableSchema.TableColumn(schema);
				colvarReorderLevel.ColumnName = "ReorderLevel";
				colvarReorderLevel.DataType = DbType.Int32;
				colvarReorderLevel.MaxLength = 0;
				colvarReorderLevel.AutoIncrement = false;
				colvarReorderLevel.IsNullable = true;
				colvarReorderLevel.IsPrimaryKey = false;
				colvarReorderLevel.IsForeignKey = false;
				colvarReorderLevel.IsReadOnly = false;
				
						colvarReorderLevel.DefaultSetting = @"((0))";
				colvarReorderLevel.ForeignKeyTableName = "";
				schema.Columns.Add(colvarReorderLevel);
				
				TableSchema.TableColumn colvarDiscontinued = new TableSchema.TableColumn(schema);
				colvarDiscontinued.ColumnName = "Discontinued";
				colvarDiscontinued.DataType = DbType.Boolean;
				colvarDiscontinued.MaxLength = 0;
				colvarDiscontinued.AutoIncrement = false;
				colvarDiscontinued.IsNullable = false;
				colvarDiscontinued.IsPrimaryKey = false;
				colvarDiscontinued.IsForeignKey = false;
				colvarDiscontinued.IsReadOnly = false;
				
						colvarDiscontinued.DefaultSetting = @"((0))";
				colvarDiscontinued.ForeignKeyTableName = "";
				schema.Columns.Add(colvarDiscontinued);
				
				BaseSchema = schema;
				//add this schema to the provider
				//so we can query it later
				DataService.Providers["Northwind"].AddSchema("Products",schema);
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

		  
		[XmlAttribute("ProductName")]
		public string ProductName 
		{
			get { return GetColumnValue<string>("ProductName"); }

			set { SetColumnValue("ProductName", value); }

		}

		  
		[XmlAttribute("SupplierId")]
		public int? SupplierId 
		{
			get { return GetColumnValue<int?>("SupplierId"); }

			set { SetColumnValue("SupplierId", value); }

		}

		  
		[XmlAttribute("CategoryId")]
		public int? CategoryId 
		{
			get { return GetColumnValue<int?>("CategoryId"); }

			set { SetColumnValue("CategoryId", value); }

		}

		  
		[XmlAttribute("QuantityPerUnit")]
		public string QuantityPerUnit 
		{
			get { return GetColumnValue<string>("QuantityPerUnit"); }

			set { SetColumnValue("QuantityPerUnit", value); }

		}

		  
		[XmlAttribute("UnitPrice")]
		public decimal? UnitPrice 
		{
			get { return GetColumnValue<decimal?>("UnitPrice"); }

			set { SetColumnValue("UnitPrice", value); }

		}

		  
		[XmlAttribute("UnitsInStock")]
		public int? UnitsInStock 
		{
			get { return GetColumnValue<int?>("UnitsInStock"); }

			set { SetColumnValue("UnitsInStock", value); }

		}

		  
		[XmlAttribute("UnitsOnOrder")]
		public int? UnitsOnOrder 
		{
			get { return GetColumnValue<int?>("UnitsOnOrder"); }

			set { SetColumnValue("UnitsOnOrder", value); }

		}

		  
		[XmlAttribute("ReorderLevel")]
		public int? ReorderLevel 
		{
			get { return GetColumnValue<int?>("ReorderLevel"); }

			set { SetColumnValue("ReorderLevel", value); }

		}

		  
		[XmlAttribute("Discontinued")]
		public bool Discontinued 
		{
			get { return GetColumnValue<bool>("Discontinued"); }

			set { SetColumnValue("Discontinued", value); }

		}

		
		#endregion
		
		
		#region PrimaryKey Methods
		
		public OrderDetailCollection OrderDetails()
		{
			return new OrderDetailCollection().Where(OrderDetail.Columns.ProductId, Id).Load();
		}

		#endregion
		
			
		
		#region ForeignKey Properties
		
		/// <summary>
		/// Returns a Category ActiveRecord object related to this Product
		/// 
		/// </summary>
		public Category Category
		{
			get { return Category.FetchByID(this.CategoryId); }

			set { SetColumnValue("CategoryId", value.Id); }

		}

		
		
		/// <summary>
		/// Returns a Supplier ActiveRecord object related to this Product
		/// 
		/// </summary>
		public Supplier Supplier
		{
			get { return Supplier.FetchByID(this.SupplierId); }

			set { SetColumnValue("SupplierId", value.Id); }

		}

		
		
		#endregion
		
		
		
		//no ManyToMany tables defined (0)
		
		#region ObjectDataSource support
		
		
		/// <summary>
		/// Inserts a record, can be used with the Object Data Source
		/// </summary>
		public static void Insert(int varId,string varProductName,int? varSupplierId,int? varCategoryId,string varQuantityPerUnit,decimal? varUnitPrice,int? varUnitsInStock,int? varUnitsOnOrder,int? varReorderLevel,bool varDiscontinued)
		{
			Product item = new Product();
			
			item.Id = varId;
			
			item.ProductName = varProductName;
			
			item.SupplierId = varSupplierId;
			
			item.CategoryId = varCategoryId;
			
			item.QuantityPerUnit = varQuantityPerUnit;
			
			item.UnitPrice = varUnitPrice;
			
			item.UnitsInStock = varUnitsInStock;
			
			item.UnitsOnOrder = varUnitsOnOrder;
			
			item.ReorderLevel = varReorderLevel;
			
			item.Discontinued = varDiscontinued;
			
		
			if (System.Web.HttpContext.Current != null)
				item.Save(System.Web.HttpContext.Current.User.Identity.Name);
			else
				item.Save(System.Threading.Thread.CurrentPrincipal.Identity.Name);
		}

		
		/// <summary>
		/// Updates a record, can be used with the Object Data Source
		/// </summary>
		public static void Update(int varId,string varProductName,int? varSupplierId,int? varCategoryId,string varQuantityPerUnit,decimal? varUnitPrice,int? varUnitsInStock,int? varUnitsOnOrder,int? varReorderLevel,bool varDiscontinued)
		{
			Product item = new Product();
			
				item.Id = varId;
				
				item.ProductName = varProductName;
				
				item.SupplierId = varSupplierId;
				
				item.CategoryId = varCategoryId;
				
				item.QuantityPerUnit = varQuantityPerUnit;
				
				item.UnitPrice = varUnitPrice;
				
				item.UnitsInStock = varUnitsInStock;
				
				item.UnitsOnOrder = varUnitsOnOrder;
				
				item.ReorderLevel = varReorderLevel;
				
				item.Discontinued = varDiscontinued;
				
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
			 public static string ProductName = @"ProductName";
			 public static string SupplierId = @"SupplierId";
			 public static string CategoryId = @"CategoryId";
			 public static string QuantityPerUnit = @"QuantityPerUnit";
			 public static string UnitPrice = @"UnitPrice";
			 public static string UnitsInStock = @"UnitsInStock";
			 public static string UnitsOnOrder = @"UnitsOnOrder";
			 public static string ReorderLevel = @"ReorderLevel";
			 public static string Discontinued = @"Discontinued";
						
		}

		#endregion
	}

}

