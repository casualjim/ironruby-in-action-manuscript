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
    /// Controller class for OrderDetails
    /// </summary>
    [System.ComponentModel.DataObject]
    public partial class OrderDetailController
    {
        // Preload our schema..
        OrderDetail thisSchemaLoad = new OrderDetail();
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
        public OrderDetailCollection FetchAll()
        {
            OrderDetailCollection coll = new OrderDetailCollection();
            Query qry = new Query(OrderDetail.Schema);
            coll.LoadAndCloseReader(qry.ExecuteReader());
            return coll;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public OrderDetailCollection FetchByID(object Id)
        {
            OrderDetailCollection coll = new OrderDetailCollection().Where("Id", Id).Load();
            return coll;
        }

		
		[DataObjectMethod(DataObjectMethodType.Select, false)]
        public OrderDetailCollection FetchByQuery(Query qry)
        {
            OrderDetailCollection coll = new OrderDetailCollection();
            coll.LoadAndCloseReader(qry.ExecuteReader()); 
            return coll;
        }

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool Delete(object Id)
        {
            return (OrderDetail.Delete(Id) == 1);
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public bool Destroy(object Id)
        {
            return (OrderDetail.Destroy(Id) == 1);
        }

        
        
    	
	    /// <summary>
	    /// Inserts a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Insert, true)]
	    public void Insert(int Id,int OrderId,int ProductId,decimal UnitPrice,short Quantity,decimal Discount)
	    {
		    OrderDetail item = new OrderDetail();
		    
            item.Id = Id;
            
            item.OrderId = OrderId;
            
            item.ProductId = ProductId;
            
            item.UnitPrice = UnitPrice;
            
            item.Quantity = Quantity;
            
            item.Discount = Discount;
            
	    
		    item.Save(UserName);
	    }

    	
	    /// <summary>
	    /// Updates a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Update, true)]
	    public void Update(int Id,int OrderId,int ProductId,decimal UnitPrice,short Quantity,decimal Discount)
	    {
		    OrderDetail item = new OrderDetail();
		    
				item.Id = Id;
				
				item.OrderId = OrderId;
				
				item.ProductId = ProductId;
				
				item.UnitPrice = UnitPrice;
				
				item.Quantity = Quantity;
				
				item.Discount = Discount;
				
		    item.MarkOld();
		    item.Save(UserName);
	    }

    }

}

