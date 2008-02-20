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
	/// Strongly-typed collection for the Order class.
	/// </summary>
	[Serializable]
	public partial class OrderCollection : ActiveList<Order, OrderCollection> 
	{	   
		public OrderCollection() {}

	}

	/// <summary>
	/// This is an ActiveRecord class which wraps the Orders table.
	/// </summary>
	[Serializable]
	public partial class Order : ActiveRecord<Order>
	{
		#region .ctors and Default Settings
		
		public Order()
		{
		  SetSQLProps();
		  InitSetDefaults();
		  MarkNew();
		}

		
		private void InitSetDefaults() { SetDefaults(); }

		
		public Order(bool useDatabaseDefaults)
		{
			SetSQLProps();
			if(useDatabaseDefaults)
				ForceDefaults();
			MarkNew();
		}

		public Order(object keyID)
		{
			SetSQLProps();
			InitSetDefaults();
			LoadByKey(keyID);
		}

		 
		public Order(string columnName, object columnValue)
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
				TableSchema.Table schema = new TableSchema.Table("Orders", TableType.Table, DataService.GetInstance("Northwind"));
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
				
				TableSchema.TableColumn colvarCustomerId = new TableSchema.TableColumn(schema);
				colvarCustomerId.ColumnName = "CustomerId";
				colvarCustomerId.DataType = DbType.Int32;
				colvarCustomerId.MaxLength = 0;
				colvarCustomerId.AutoIncrement = false;
				colvarCustomerId.IsNullable = true;
				colvarCustomerId.IsPrimaryKey = false;
				colvarCustomerId.IsForeignKey = false;
				colvarCustomerId.IsReadOnly = false;
				colvarCustomerId.DefaultSetting = @"";
				colvarCustomerId.ForeignKeyTableName = "";
				schema.Columns.Add(colvarCustomerId);
				
				TableSchema.TableColumn colvarEmployeeId = new TableSchema.TableColumn(schema);
				colvarEmployeeId.ColumnName = "EmployeeId";
				colvarEmployeeId.DataType = DbType.Int32;
				colvarEmployeeId.MaxLength = 0;
				colvarEmployeeId.AutoIncrement = false;
				colvarEmployeeId.IsNullable = true;
				colvarEmployeeId.IsPrimaryKey = false;
				colvarEmployeeId.IsForeignKey = false;
				colvarEmployeeId.IsReadOnly = false;
				colvarEmployeeId.DefaultSetting = @"";
				colvarEmployeeId.ForeignKeyTableName = "";
				schema.Columns.Add(colvarEmployeeId);
				
				TableSchema.TableColumn colvarOrderDate = new TableSchema.TableColumn(schema);
				colvarOrderDate.ColumnName = "OrderDate";
				colvarOrderDate.DataType = DbType.DateTime;
				colvarOrderDate.MaxLength = 0;
				colvarOrderDate.AutoIncrement = false;
				colvarOrderDate.IsNullable = true;
				colvarOrderDate.IsPrimaryKey = false;
				colvarOrderDate.IsForeignKey = false;
				colvarOrderDate.IsReadOnly = false;
				colvarOrderDate.DefaultSetting = @"";
				colvarOrderDate.ForeignKeyTableName = "";
				schema.Columns.Add(colvarOrderDate);
				
				TableSchema.TableColumn colvarRequiredDate = new TableSchema.TableColumn(schema);
				colvarRequiredDate.ColumnName = "RequiredDate";
				colvarRequiredDate.DataType = DbType.DateTime;
				colvarRequiredDate.MaxLength = 0;
				colvarRequiredDate.AutoIncrement = false;
				colvarRequiredDate.IsNullable = true;
				colvarRequiredDate.IsPrimaryKey = false;
				colvarRequiredDate.IsForeignKey = false;
				colvarRequiredDate.IsReadOnly = false;
				colvarRequiredDate.DefaultSetting = @"";
				colvarRequiredDate.ForeignKeyTableName = "";
				schema.Columns.Add(colvarRequiredDate);
				
				TableSchema.TableColumn colvarShippedDate = new TableSchema.TableColumn(schema);
				colvarShippedDate.ColumnName = "ShippedDate";
				colvarShippedDate.DataType = DbType.DateTime;
				colvarShippedDate.MaxLength = 0;
				colvarShippedDate.AutoIncrement = false;
				colvarShippedDate.IsNullable = true;
				colvarShippedDate.IsPrimaryKey = false;
				colvarShippedDate.IsForeignKey = false;
				colvarShippedDate.IsReadOnly = false;
				colvarShippedDate.DefaultSetting = @"";
				colvarShippedDate.ForeignKeyTableName = "";
				schema.Columns.Add(colvarShippedDate);
				
				TableSchema.TableColumn colvarShipViaId = new TableSchema.TableColumn(schema);
				colvarShipViaId.ColumnName = "ShipViaId";
				colvarShipViaId.DataType = DbType.Int32;
				colvarShipViaId.MaxLength = 0;
				colvarShipViaId.AutoIncrement = false;
				colvarShipViaId.IsNullable = true;
				colvarShipViaId.IsPrimaryKey = false;
				colvarShipViaId.IsForeignKey = false;
				colvarShipViaId.IsReadOnly = false;
				colvarShipViaId.DefaultSetting = @"";
				colvarShipViaId.ForeignKeyTableName = "";
				schema.Columns.Add(colvarShipViaId);
				
				TableSchema.TableColumn colvarFreight = new TableSchema.TableColumn(schema);
				colvarFreight.ColumnName = "Freight";
				colvarFreight.DataType = DbType.Currency;
				colvarFreight.MaxLength = 0;
				colvarFreight.AutoIncrement = false;
				colvarFreight.IsNullable = true;
				colvarFreight.IsPrimaryKey = false;
				colvarFreight.IsForeignKey = false;
				colvarFreight.IsReadOnly = false;
				
						colvarFreight.DefaultSetting = @"((0))";
				colvarFreight.ForeignKeyTableName = "";
				schema.Columns.Add(colvarFreight);
				
				TableSchema.TableColumn colvarShipName = new TableSchema.TableColumn(schema);
				colvarShipName.ColumnName = "ShipName";
				colvarShipName.DataType = DbType.String;
				colvarShipName.MaxLength = 40;
				colvarShipName.AutoIncrement = false;
				colvarShipName.IsNullable = true;
				colvarShipName.IsPrimaryKey = false;
				colvarShipName.IsForeignKey = false;
				colvarShipName.IsReadOnly = false;
				colvarShipName.DefaultSetting = @"";
				colvarShipName.ForeignKeyTableName = "";
				schema.Columns.Add(colvarShipName);
				
				TableSchema.TableColumn colvarShipAddress = new TableSchema.TableColumn(schema);
				colvarShipAddress.ColumnName = "ShipAddress";
				colvarShipAddress.DataType = DbType.String;
				colvarShipAddress.MaxLength = 60;
				colvarShipAddress.AutoIncrement = false;
				colvarShipAddress.IsNullable = true;
				colvarShipAddress.IsPrimaryKey = false;
				colvarShipAddress.IsForeignKey = false;
				colvarShipAddress.IsReadOnly = false;
				colvarShipAddress.DefaultSetting = @"";
				colvarShipAddress.ForeignKeyTableName = "";
				schema.Columns.Add(colvarShipAddress);
				
				TableSchema.TableColumn colvarShipCity = new TableSchema.TableColumn(schema);
				colvarShipCity.ColumnName = "ShipCity";
				colvarShipCity.DataType = DbType.String;
				colvarShipCity.MaxLength = 15;
				colvarShipCity.AutoIncrement = false;
				colvarShipCity.IsNullable = true;
				colvarShipCity.IsPrimaryKey = false;
				colvarShipCity.IsForeignKey = false;
				colvarShipCity.IsReadOnly = false;
				colvarShipCity.DefaultSetting = @"";
				colvarShipCity.ForeignKeyTableName = "";
				schema.Columns.Add(colvarShipCity);
				
				TableSchema.TableColumn colvarShipRegion = new TableSchema.TableColumn(schema);
				colvarShipRegion.ColumnName = "ShipRegion";
				colvarShipRegion.DataType = DbType.String;
				colvarShipRegion.MaxLength = 15;
				colvarShipRegion.AutoIncrement = false;
				colvarShipRegion.IsNullable = true;
				colvarShipRegion.IsPrimaryKey = false;
				colvarShipRegion.IsForeignKey = false;
				colvarShipRegion.IsReadOnly = false;
				colvarShipRegion.DefaultSetting = @"";
				colvarShipRegion.ForeignKeyTableName = "";
				schema.Columns.Add(colvarShipRegion);
				
				TableSchema.TableColumn colvarShipPostalCode = new TableSchema.TableColumn(schema);
				colvarShipPostalCode.ColumnName = "ShipPostalCode";
				colvarShipPostalCode.DataType = DbType.String;
				colvarShipPostalCode.MaxLength = 10;
				colvarShipPostalCode.AutoIncrement = false;
				colvarShipPostalCode.IsNullable = true;
				colvarShipPostalCode.IsPrimaryKey = false;
				colvarShipPostalCode.IsForeignKey = false;
				colvarShipPostalCode.IsReadOnly = false;
				colvarShipPostalCode.DefaultSetting = @"";
				colvarShipPostalCode.ForeignKeyTableName = "";
				schema.Columns.Add(colvarShipPostalCode);
				
				TableSchema.TableColumn colvarShipCountry = new TableSchema.TableColumn(schema);
				colvarShipCountry.ColumnName = "ShipCountry";
				colvarShipCountry.DataType = DbType.String;
				colvarShipCountry.MaxLength = 15;
				colvarShipCountry.AutoIncrement = false;
				colvarShipCountry.IsNullable = true;
				colvarShipCountry.IsPrimaryKey = false;
				colvarShipCountry.IsForeignKey = false;
				colvarShipCountry.IsReadOnly = false;
				colvarShipCountry.DefaultSetting = @"";
				colvarShipCountry.ForeignKeyTableName = "";
				schema.Columns.Add(colvarShipCountry);
				
				BaseSchema = schema;
				//add this schema to the provider
				//so we can query it later
				DataService.Providers["Northwind"].AddSchema("Orders",schema);
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

		  
		[XmlAttribute("CustomerId")]
		public int? CustomerId 
		{
			get { return GetColumnValue<int?>("CustomerId"); }

			set { SetColumnValue("CustomerId", value); }

		}

		  
		[XmlAttribute("EmployeeId")]
		public int? EmployeeId 
		{
			get { return GetColumnValue<int?>("EmployeeId"); }

			set { SetColumnValue("EmployeeId", value); }

		}

		  
		[XmlAttribute("OrderDate")]
		public DateTime? OrderDate 
		{
			get { return GetColumnValue<DateTime?>("OrderDate"); }

			set { SetColumnValue("OrderDate", value); }

		}

		  
		[XmlAttribute("RequiredDate")]
		public DateTime? RequiredDate 
		{
			get { return GetColumnValue<DateTime?>("RequiredDate"); }

			set { SetColumnValue("RequiredDate", value); }

		}

		  
		[XmlAttribute("ShippedDate")]
		public DateTime? ShippedDate 
		{
			get { return GetColumnValue<DateTime?>("ShippedDate"); }

			set { SetColumnValue("ShippedDate", value); }

		}

		  
		[XmlAttribute("ShipViaId")]
		public int? ShipViaId 
		{
			get { return GetColumnValue<int?>("ShipViaId"); }

			set { SetColumnValue("ShipViaId", value); }

		}

		  
		[XmlAttribute("Freight")]
		public decimal? Freight 
		{
			get { return GetColumnValue<decimal?>("Freight"); }

			set { SetColumnValue("Freight", value); }

		}

		  
		[XmlAttribute("ShipName")]
		public string ShipName 
		{
			get { return GetColumnValue<string>("ShipName"); }

			set { SetColumnValue("ShipName", value); }

		}

		  
		[XmlAttribute("ShipAddress")]
		public string ShipAddress 
		{
			get { return GetColumnValue<string>("ShipAddress"); }

			set { SetColumnValue("ShipAddress", value); }

		}

		  
		[XmlAttribute("ShipCity")]
		public string ShipCity 
		{
			get { return GetColumnValue<string>("ShipCity"); }

			set { SetColumnValue("ShipCity", value); }

		}

		  
		[XmlAttribute("ShipRegion")]
		public string ShipRegion 
		{
			get { return GetColumnValue<string>("ShipRegion"); }

			set { SetColumnValue("ShipRegion", value); }

		}

		  
		[XmlAttribute("ShipPostalCode")]
		public string ShipPostalCode 
		{
			get { return GetColumnValue<string>("ShipPostalCode"); }

			set { SetColumnValue("ShipPostalCode", value); }

		}

		  
		[XmlAttribute("ShipCountry")]
		public string ShipCountry 
		{
			get { return GetColumnValue<string>("ShipCountry"); }

			set { SetColumnValue("ShipCountry", value); }

		}

		
		#endregion
		
		
			
		
		//no foreign key tables defined (0)
		
		
		
		//no ManyToMany tables defined (0)
		
		#region ObjectDataSource support
		
		
		/// <summary>
		/// Inserts a record, can be used with the Object Data Source
		/// </summary>
		public static void Insert(int varId,int? varCustomerId,int? varEmployeeId,DateTime? varOrderDate,DateTime? varRequiredDate,DateTime? varShippedDate,int? varShipViaId,decimal? varFreight,string varShipName,string varShipAddress,string varShipCity,string varShipRegion,string varShipPostalCode,string varShipCountry)
		{
			Order item = new Order();
			
			item.Id = varId;
			
			item.CustomerId = varCustomerId;
			
			item.EmployeeId = varEmployeeId;
			
			item.OrderDate = varOrderDate;
			
			item.RequiredDate = varRequiredDate;
			
			item.ShippedDate = varShippedDate;
			
			item.ShipViaId = varShipViaId;
			
			item.Freight = varFreight;
			
			item.ShipName = varShipName;
			
			item.ShipAddress = varShipAddress;
			
			item.ShipCity = varShipCity;
			
			item.ShipRegion = varShipRegion;
			
			item.ShipPostalCode = varShipPostalCode;
			
			item.ShipCountry = varShipCountry;
			
		
			if (System.Web.HttpContext.Current != null)
				item.Save(System.Web.HttpContext.Current.User.Identity.Name);
			else
				item.Save(System.Threading.Thread.CurrentPrincipal.Identity.Name);
		}

		
		/// <summary>
		/// Updates a record, can be used with the Object Data Source
		/// </summary>
		public static void Update(int varId,int? varCustomerId,int? varEmployeeId,DateTime? varOrderDate,DateTime? varRequiredDate,DateTime? varShippedDate,int? varShipViaId,decimal? varFreight,string varShipName,string varShipAddress,string varShipCity,string varShipRegion,string varShipPostalCode,string varShipCountry)
		{
			Order item = new Order();
			
				item.Id = varId;
				
				item.CustomerId = varCustomerId;
				
				item.EmployeeId = varEmployeeId;
				
				item.OrderDate = varOrderDate;
				
				item.RequiredDate = varRequiredDate;
				
				item.ShippedDate = varShippedDate;
				
				item.ShipViaId = varShipViaId;
				
				item.Freight = varFreight;
				
				item.ShipName = varShipName;
				
				item.ShipAddress = varShipAddress;
				
				item.ShipCity = varShipCity;
				
				item.ShipRegion = varShipRegion;
				
				item.ShipPostalCode = varShipPostalCode;
				
				item.ShipCountry = varShipCountry;
				
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
			 public static string CustomerId = @"CustomerId";
			 public static string EmployeeId = @"EmployeeId";
			 public static string OrderDate = @"OrderDate";
			 public static string RequiredDate = @"RequiredDate";
			 public static string ShippedDate = @"ShippedDate";
			 public static string ShipViaId = @"ShipViaId";
			 public static string Freight = @"Freight";
			 public static string ShipName = @"ShipName";
			 public static string ShipAddress = @"ShipAddress";
			 public static string ShipCity = @"ShipCity";
			 public static string ShipRegion = @"ShipRegion";
			 public static string ShipPostalCode = @"ShipPostalCode";
			 public static string ShipCountry = @"ShipCountry";
						
		}

		#endregion
	}

}

