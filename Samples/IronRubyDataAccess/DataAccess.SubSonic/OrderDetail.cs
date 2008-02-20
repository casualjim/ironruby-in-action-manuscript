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
	/// Strongly-typed collection for the OrderDetail class.
	/// </summary>
	[Serializable]
	public partial class OrderDetailCollection : ActiveList<OrderDetail, OrderDetailCollection> 
	{	   
		public OrderDetailCollection() {}

	}

	/// <summary>
	/// This is an ActiveRecord class which wraps the OrderDetails table.
	/// </summary>
	[Serializable]
	public partial class OrderDetail : ActiveRecord<OrderDetail>
	{
		#region .ctors and Default Settings
		
		public OrderDetail()
		{
		  SetSQLProps();
		  InitSetDefaults();
		  MarkNew();
		}

		
		private void InitSetDefaults() { SetDefaults(); }

		
		public OrderDetail(bool useDatabaseDefaults)
		{
			SetSQLProps();
			if(useDatabaseDefaults)
				ForceDefaults();
			MarkNew();
		}

		public OrderDetail(object keyID)
		{
			SetSQLProps();
			InitSetDefaults();
			LoadByKey(keyID);
		}

		 
		public OrderDetail(string columnName, object columnValue)
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
				TableSchema.Table schema = new TableSchema.Table("OrderDetails", TableType.Table, DataService.GetInstance("Northwind"));
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
				
				TableSchema.TableColumn colvarOrderId = new TableSchema.TableColumn(schema);
				colvarOrderId.ColumnName = "OrderId";
				colvarOrderId.DataType = DbType.Int32;
				colvarOrderId.MaxLength = 0;
				colvarOrderId.AutoIncrement = false;
				colvarOrderId.IsNullable = false;
				colvarOrderId.IsPrimaryKey = false;
				colvarOrderId.IsForeignKey = false;
				colvarOrderId.IsReadOnly = false;
				colvarOrderId.DefaultSetting = @"";
				colvarOrderId.ForeignKeyTableName = "";
				schema.Columns.Add(colvarOrderId);
				
				TableSchema.TableColumn colvarProductId = new TableSchema.TableColumn(schema);
				colvarProductId.ColumnName = "ProductId";
				colvarProductId.DataType = DbType.Int32;
				colvarProductId.MaxLength = 0;
				colvarProductId.AutoIncrement = false;
				colvarProductId.IsNullable = false;
				colvarProductId.IsPrimaryKey = false;
				colvarProductId.IsForeignKey = true;
				colvarProductId.IsReadOnly = false;
				colvarProductId.DefaultSetting = @"";
				
					colvarProductId.ForeignKeyTableName = "Products";
				schema.Columns.Add(colvarProductId);
				
				TableSchema.TableColumn colvarUnitPrice = new TableSchema.TableColumn(schema);
				colvarUnitPrice.ColumnName = "UnitPrice";
				colvarUnitPrice.DataType = DbType.Currency;
				colvarUnitPrice.MaxLength = 0;
				colvarUnitPrice.AutoIncrement = false;
				colvarUnitPrice.IsNullable = false;
				colvarUnitPrice.IsPrimaryKey = false;
				colvarUnitPrice.IsForeignKey = false;
				colvarUnitPrice.IsReadOnly = false;
				
						colvarUnitPrice.DefaultSetting = @"((0))";
				colvarUnitPrice.ForeignKeyTableName = "";
				schema.Columns.Add(colvarUnitPrice);
				
				TableSchema.TableColumn colvarQuantity = new TableSchema.TableColumn(schema);
				colvarQuantity.ColumnName = "Quantity";
				colvarQuantity.DataType = DbType.Int16;
				colvarQuantity.MaxLength = 0;
				colvarQuantity.AutoIncrement = false;
				colvarQuantity.IsNullable = false;
				colvarQuantity.IsPrimaryKey = false;
				colvarQuantity.IsForeignKey = false;
				colvarQuantity.IsReadOnly = false;
				
						colvarQuantity.DefaultSetting = @"((1))";
				colvarQuantity.ForeignKeyTableName = "";
				schema.Columns.Add(colvarQuantity);
				
				TableSchema.TableColumn colvarDiscount = new TableSchema.TableColumn(schema);
				colvarDiscount.ColumnName = "Discount";
				colvarDiscount.DataType = DbType.Decimal;
				colvarDiscount.MaxLength = 0;
				colvarDiscount.AutoIncrement = false;
				colvarDiscount.IsNullable = false;
				colvarDiscount.IsPrimaryKey = false;
				colvarDiscount.IsForeignKey = false;
				colvarDiscount.IsReadOnly = false;
				
						colvarDiscount.DefaultSetting = @"((0))";
				colvarDiscount.ForeignKeyTableName = "";
				schema.Columns.Add(colvarDiscount);
				
				BaseSchema = schema;
				//add this schema to the provider
				//so we can query it later
				DataService.Providers["Northwind"].AddSchema("OrderDetails",schema);
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

		  
		[XmlAttribute("OrderId")]
		public int OrderId 
		{
			get { return GetColumnValue<int>("OrderId"); }

			set { SetColumnValue("OrderId", value); }

		}

		  
		[XmlAttribute("ProductId")]
		public int ProductId 
		{
			get { return GetColumnValue<int>("ProductId"); }

			set { SetColumnValue("ProductId", value); }

		}

		  
		[XmlAttribute("UnitPrice")]
		public decimal UnitPrice 
		{
			get { return GetColumnValue<decimal>("UnitPrice"); }

			set { SetColumnValue("UnitPrice", value); }

		}

		  
		[XmlAttribute("Quantity")]
		public short Quantity 
		{
			get { return GetColumnValue<short>("Quantity"); }

			set { SetColumnValue("Quantity", value); }

		}

		  
		[XmlAttribute("Discount")]
		public decimal Discount 
		{
			get { return GetColumnValue<decimal>("Discount"); }

			set { SetColumnValue("Discount", value); }

		}

		
		#endregion
		
		
			
		
		#region ForeignKey Properties
		
		/// <summary>
		/// Returns a Product ActiveRecord object related to this OrderDetail
		/// 
		/// </summary>
		public Product Product
		{
			get { return Product.FetchByID(this.ProductId); }

			set { SetColumnValue("ProductId", value.Id); }

		}

		
		
		#endregion
		
		
		
		//no ManyToMany tables defined (0)
		
		#region ObjectDataSource support
		
		
		/// <summary>
		/// Inserts a record, can be used with the Object Data Source
		/// </summary>
		public static void Insert(int varId,int varOrderId,int varProductId,decimal varUnitPrice,short varQuantity,decimal varDiscount)
		{
			OrderDetail item = new OrderDetail();
			
			item.Id = varId;
			
			item.OrderId = varOrderId;
			
			item.ProductId = varProductId;
			
			item.UnitPrice = varUnitPrice;
			
			item.Quantity = varQuantity;
			
			item.Discount = varDiscount;
			
		
			if (System.Web.HttpContext.Current != null)
				item.Save(System.Web.HttpContext.Current.User.Identity.Name);
			else
				item.Save(System.Threading.Thread.CurrentPrincipal.Identity.Name);
		}

		
		/// <summary>
		/// Updates a record, can be used with the Object Data Source
		/// </summary>
		public static void Update(int varId,int varOrderId,int varProductId,decimal varUnitPrice,short varQuantity,decimal varDiscount)
		{
			OrderDetail item = new OrderDetail();
			
				item.Id = varId;
				
				item.OrderId = varOrderId;
				
				item.ProductId = varProductId;
				
				item.UnitPrice = varUnitPrice;
				
				item.Quantity = varQuantity;
				
				item.Discount = varDiscount;
				
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
			 public static string OrderId = @"OrderId";
			 public static string ProductId = @"ProductId";
			 public static string UnitPrice = @"UnitPrice";
			 public static string Quantity = @"Quantity";
			 public static string Discount = @"Discount";
						
		}

		#endregion
	}

}

