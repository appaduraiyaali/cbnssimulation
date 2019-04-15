public virtual class BaseLineItem{
        public Double unitAmount{get;set;}
        public String quantity{get;set;}
        public String description{get;set;}
        public Double amount{get;set;}
        public DateTime from_date{get;set;}
        public DateTime to_date{get;set;}
        public BaseLineItem(String ua,String quan,String descrip,String amt,String curCode,String fdate,String tdate) {
            long amnt = Long.valueOf(ua);
            from_date = DateTime.newInstance(Long.valueOf(fdate)*1000);
            to_date = DateTime.newInstance(Long.valueOf(tdate)*1000);
            unitAmount = ChargebeeUtil.convertToHigherOrderCurrency(curCode,amnt);
            quantity=quan;
            description=descrip;
            amnt = Long.valueOf(amt);
            amount=ChargebeeUtil.convertToHigherOrderCurrency(curCode,amnt);
        }
    }