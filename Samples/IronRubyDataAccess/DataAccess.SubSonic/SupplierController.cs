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
    /// Controller class for Suppliers
    /// </summary>
    [System.ComponentModel.DataObject]
    public partial class SupplierController
    {
        // Preload our schema..
        Supplier thisSchemaLoad = new Supplier();
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
        public SupplierCollection FetchAll()
        {
            SupplierCollection coll = new SupplierCollection();
            Query qry = new Query(Supplier.Schema);
            coll.LoadAndCloseReader(qry.ExecuteReader());
            return coll;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public SupplierCollection FetchByID(object Id)
        {
            SupplierCollection coll = new SupplierCollection().Where("Id", Id).Load();
            return coll;
        }

		
		[DataObjectMethod(DataObjectMethodType.Select, false)]
        public SupplierCollection FetchByQuery(Query qry)
        {
            SupplierCollection coll = new SupplierCollection();
            coll.LoadAndCloseReader(qry.ExecuteReader()); 
            return coll;
        }

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool Delete(object Id)
        {
            return (Supplier.Delete(Id) == 1);
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public bool Destroy(object Id)
        {
            return (Supplier.Destroy(Id) == 1);
        }

        
        
    	
	    /// <summary>
	    /// Inserts a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Insert, true)]
	    public void Insert(int Id,string CompanyName,string ContactName,string ContactTitle,string Address,string City,string Region,string PostalCode,string Country,string Phone,string Fax,string HomePage)
	    {
		    Supplier item = new Supplier();
		    
            item.Id = Id;
            
            item.CompanyName = CompanyName;
            
            item.ContactName = ContactName;
            
            item.ContactTitle = ContactTitle;
            
            item.Address = Address;
            
            item.City = City;
            
            item.Region = Region;
            
            item.PostalCode = PostalCode;
            
            item.Country = Country;
            
            item.Phone = Phone;
            
            item.Fax = Fax;
            
            item.HomePage = HomePage;
            
	    
		    item.Save(UserName);
	    }

    	
	    /// <summary>
	    /// Updates a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Update, true)]
	    public void Update(int Id,string CompanyName,string ContactName,string ContactTitle,string Address,string City,string Region,string PostalCode,string Country,string Phone,string Fax,string HomePage)
	    {
		    Supplier item = new Supplier();
		    
				item.Id = Id;
				
				item.CompanyName = CompanyName;
				
				item.ContactName = ContactName;
				
				item.ContactTitle = ContactTitle;
				
				item.Address = Address;
				
				item.City = City;
				
				item.Region = Region;
				
				item.PostalCode = PostalCode;
				
				item.Country = Country;
				
				item.Phone = Phone;
				
				item.Fax = Fax;
				
				item.HomePage = HomePage;
				
		    item.MarkOld();
		    item.Save(UserName);
	    }

    }

}

