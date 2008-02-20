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
    /// Controller class for Products
    /// </summary>
    [System.ComponentModel.DataObject]
    public partial class ProductController
    {
        // Preload our schema..
        Product thisSchemaLoad = new Product();
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
        public ProductCollection FetchAll()
        {
            ProductCollection coll = new ProductCollection();
            Query qry = new Query(Product.Schema);
            coll.LoadAndCloseReader(qry.ExecuteReader());
            return coll;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public ProductCollection FetchByID(object Id)
        {
            ProductCollection coll = new ProductCollection().Where("Id", Id).Load();
            return coll;
        }

		
		[DataObjectMethod(DataObjectMethodType.Select, false)]
        public ProductCollection FetchByQuery(Query qry)
        {
            ProductCollection coll = new ProductCollection();
            coll.LoadAndCloseReader(qry.ExecuteReader()); 
            return coll;
        }

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool Delete(object Id)
        {
            return (Product.Delete(Id) == 1);
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public bool Destroy(object Id)
        {
            return (Product.Destroy(Id) == 1);
        }

        
        
    	
	    /// <summary>
	    /// Inserts a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Insert, true)]
	    public void Insert(int Id,string ProductName,int? SupplierId,int? CategoryId,string QuantityPerUnit,decimal? UnitPrice,int? UnitsInStock,int? UnitsOnOrder,int? ReorderLevel,bool Discontinued)
	    {
		    Product item = new Product();
		    
            item.Id = Id;
            
            item.ProductName = ProductName;
            
            item.SupplierId = SupplierId;
            
            item.CategoryId = CategoryId;
            
            item.QuantityPerUnit = QuantityPerUnit;
            
            item.UnitPrice = UnitPrice;
            
            item.UnitsInStock = UnitsInStock;
            
            item.UnitsOnOrder = UnitsOnOrder;
            
            item.ReorderLevel = ReorderLevel;
            
            item.Discontinued = Discontinued;
            
	    
		    item.Save(UserName);
	    }

    	
	    /// <summary>
	    /// Updates a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Update, true)]
	    public void Update(int Id,string ProductName,int? SupplierId,int? CategoryId,string QuantityPerUnit,decimal? UnitPrice,int? UnitsInStock,int? UnitsOnOrder,int? ReorderLevel,bool Discontinued)
	    {
		    Product item = new Product();
		    
				item.Id = Id;
				
				item.ProductName = ProductName;
				
				item.SupplierId = SupplierId;
				
				item.CategoryId = CategoryId;
				
				item.QuantityPerUnit = QuantityPerUnit;
				
				item.UnitPrice = UnitPrice;
				
				item.UnitsInStock = UnitsInStock;
				
				item.UnitsOnOrder = UnitsOnOrder;
				
				item.ReorderLevel = ReorderLevel;
				
				item.Discontinued = Discontinued;
				
		    item.MarkOld();
		    item.Save(UserName);
	    }

    }

}

