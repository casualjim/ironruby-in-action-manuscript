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
    /// Controller class for Shippers
    /// </summary>
    [System.ComponentModel.DataObject]
    public partial class ShipperController
    {
        // Preload our schema..
        Shipper thisSchemaLoad = new Shipper();
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
        public ShipperCollection FetchAll()
        {
            ShipperCollection coll = new ShipperCollection();
            Query qry = new Query(Shipper.Schema);
            coll.LoadAndCloseReader(qry.ExecuteReader());
            return coll;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public ShipperCollection FetchByID(object Id)
        {
            ShipperCollection coll = new ShipperCollection().Where("Id", Id).Load();
            return coll;
        }

		
		[DataObjectMethod(DataObjectMethodType.Select, false)]
        public ShipperCollection FetchByQuery(Query qry)
        {
            ShipperCollection coll = new ShipperCollection();
            coll.LoadAndCloseReader(qry.ExecuteReader()); 
            return coll;
        }

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool Delete(object Id)
        {
            return (Shipper.Delete(Id) == 1);
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public bool Destroy(object Id)
        {
            return (Shipper.Destroy(Id) == 1);
        }

        
        
    	
	    /// <summary>
	    /// Inserts a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Insert, true)]
	    public void Insert(int Id,string CompanyName,string Phone)
	    {
		    Shipper item = new Shipper();
		    
            item.Id = Id;
            
            item.CompanyName = CompanyName;
            
            item.Phone = Phone;
            
	    
		    item.Save(UserName);
	    }

    	
	    /// <summary>
	    /// Updates a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Update, true)]
	    public void Update(int Id,string CompanyName,string Phone)
	    {
		    Shipper item = new Shipper();
		    
				item.Id = Id;
				
				item.CompanyName = CompanyName;
				
				item.Phone = Phone;
				
		    item.MarkOld();
		    item.Save(UserName);
	    }

    }

}

