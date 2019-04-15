public class UpdateSubUrlBuilder extends URLBuilder{
    
    private static final String amp='&';
    
    public UpdateSubUrlBuilder(){
        super();
    }
    
    public UpdateSubUrlBuilder(EndPoint ep){
        super(ep);
    }
    
    public UpdateSubUrlBuilder Id(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='subscription[id]='+s;
        return this;
    }
    
    public UpdateSubUrlBuilder planId(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='subscription[plan_id]='+s;
        return this;
    }
    
    public UpdateSubUrlBuilder planQuan(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='subscription[plan_quantity]='+s;
        return this;
    }
    
    public UpdateSubUrlBuilder planUnitPrice(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='subscription[plan_unit_price]='+s;
        return this;
    }
    
    public UpdateSubUrlBuilder planSetupFee(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='subscription[setup_fee]='+s;
        return this;
    }
    
    public UpdateSubUrlBuilder startDate(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='subscription[start_date]='+s;
        return this;
    }
    
    public UpdateSubUrlBuilder trialEnd(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='subscription[trial_end]='+s;
        return this;
    }
    
    public UpdateSubUrlBuilder billingCycles(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='billing_cycles='+s;
        return this;
    }
    
    public UpdateSubUrlBuilder poNum(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='po_number='+s;
        return this;
    }
    
    public UpdateSubUrlBuilder couponId(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='coupon_ids[0]='+s;
        return this;
    }
    
    public UpdateSubUrlBuilder prorate(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='prorate='+checkBoolean(s);
        return this;
    }
    
    public UpdateSubUrlBuilder endOfTerm(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='end_of_term='+checkBoolean(s);
        return this;
    }
    
    public UpdateSubUrlBuilder invoiceImmediately(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='invoice_immediately='+checkBoolean(s);
        return this;
    }
    
    public UpdateSubUrlBuilder reactivate(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='reactivate='+checkBoolean(s);
        return this;
    }
    
    public UpdateSubUrlBuilder replaceAddons(String s){
        if(ustring!=''){
            ustring+=amp;
        }
        ustring+='replace_addon_list='+checkBoolean(s);
        return this;
    }
    
    
    
    
    
    private String checkBoolean(String s){
        List<String> boolVals=new List<String>();
        boolVals.add('true');
        boolVals.add('false');
        if(boolVals.contains(s.toLowerCase())){
            return s.toLowerCase();
        }
        else
            return null;
    }
    
    

}