public class AddonObject
    {
        public String addon {get;set;}
        public Integer qty  {get;set;}
        public Integer status  {get;set;}
        public Integer id  {get;set;}
        public decimal price {get;set;}
        public String addonCurrency {get;set;}
        
        public AddonObject(String addon,Integer qty,Integer id, Decimal price)
        {
            this.addon = addon;
            this.qty = qty;
            this.id = id;
            this.price = price;
        }     
          
        
        public void setStatus(Integer status)
        {
            this.status = status;
        }
             
    }