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
    /// Controller class for Orders
    /// </summary>
    [System.ComponentModel.DataObject]
    public partial class OrderController
    {
        // Preload our schema..
        Order thisSchemaLoad = new Order();
        private string userName = string.Empty;
        protected string UserName
        {
            get
            {
				if (userName.Length == 0) 
				{
    				if (System.Web.HttpContext.Current != null)
    				{
						userName=System.Web.HttpContext.Current.User.Identity.Name;
					}

					else
					{
						userName=System.Threading.Thread.CurrentPrincipal.Identity.Name;
					}

				}

				return userName;
            }

        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public OrderCollection FetchAll()
        {
            OrderCollection coll = new OrderCollection();
            Query qry = new Query(Order.Schema);
            coll.LoadAndCloseReader(qry.ExecuteReader());
            return coll;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public OrderCollection FetchByID(object Id)
        {
            OrderCollection coll = new OrderCollection().Where("Id", Id).Load();
            return coll;
        }

		
		[DataObjectMethod(DataObjectMethodType.Select, false)]
        public OrderCollection FetchByQuery(Query qry)
        {
            OrderCollection coll = new OrderCollection();
            coll.LoadAndCloseReader(qry.ExecuteReader()); 
            return coll;
        }

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool Delete(object Id)
        {
            return (Order.Delete(Id) == 1);
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public bool Destroy(object Id)
        {
            return (Order.Destroy(Id) == 1);
        }

        
        
    	
	    /// <summary>
	    /// Inserts a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Insert, true)]
	    public void Insert(int Id,int? CustomerId,int? EmployeeId,DateTime? OrderDate,DateTime? RequiredDate,DateTime? ShippedDate,int? ShipViaId,decimal? Freight,string ShipName,string ShipAddress,string ShipCity,string ShipRegion,string ShipPostalCode,string ShipCountry)
	    {
		    Order item = new Order();
		    
            item.Id = Id;
            
            item.CustomerId = CustomerId;
            
            item.EmployeeId = EmployeeId;
            
            item.OrderDate = OrderDate;
            
            item.RequiredDate = RequiredDate;
            
            item.ShippedDate = ShippedDate;
            
            item.ShipViaId = ShipViaId;
            
            item.Freight = Freight;
            
            item.ShipName = ShipName;
            
            item.ShipAddress = ShipAddress;
            
            item.ShipCity = ShipCity;
            
            item.ShipRegion = ShipRegion;
            
            item.ShipPostalCode = ShipPostalCode;
            
            item.ShipCountry = ShipCountry;
            
	    
		    item.Save(UserName);
	    }

    	
	    /// <summary>
	    /// Updates a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Update, true)]
	    public void Update(int Id,int? CustomerId,int? EmployeeId,DateTime? OrderDate,DateTime? RequiredDate,DateTime? ShippedDate,int? ShipViaId,decimal? Freight,string ShipName,string ShipAddress,string ShipCity,string ShipRegion,string ShipPostalCode,string ShipCountry)
	    {
		    Order item = new Order();
		    
				item.Id = Id;
				
				item.CustomerId = CustomerId;
				
				item.EmployeeId = EmployeeId;
				
				item.OrderDate = OrderDate;
				
				item.RequiredDate = RequiredDate;
				
				item.ShippedDate = ShippedDate;
				
				item.ShipViaId = ShipViaId;
				
				item.Freight = Freight;
				
				item.ShipName = ShipName;
				
				item.ShipAddress = ShipAddress;
				
				item.ShipCity = ShipCity;
				
				item.ShipRegion = ShipRegion;
				
				item.ShipPostalCode = ShipPostalCode;
				
				item.ShipCountry = ShipCountry;
				
		    item.MarkOld();
		    item.Save(UserName);
	    }

    }

}

