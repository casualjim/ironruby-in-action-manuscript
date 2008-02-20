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
	#region Tables Struct
	public partial struct Tables
	{
		
		public static string Category = @"Categories";
        
		public static string Customer = @"Customers";
        
		public static string Employee = @"Employees";
        
		public static string KeyTable = @"KeyTable";
        
		public static string OrderDetail = @"OrderDetails";
        
		public static string Order = @"Orders";
        
		public static string Product = @"Products";
        
		public static string Shipper = @"Shippers";
        
		public static string Supplier = @"Suppliers";
        
	}

	#endregion
    #region View Struct
    public partial struct Views 
    {
		
    }

    #endregion
}

#region Databases
public partial struct Databases 
{
	
	public static string Northwind = @"Northwind";
    
}

#endregion
