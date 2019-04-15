public class SubRespObj{
    public Map<String,Object> resp{get;set;}
    
    
    public SubRespObj(Map<String,Object> res){
        resp = res;
        
    }
    
    public String getId(){
        return (String)resp.get('id');
    }
    
    public String getPlanId(){
        return (String)resp.get('plan_id');
    }
    
    public String getCouponId(){
        return (String)resp.get('coupon');
    }
    
    public Integer getPlanQuan(){
        return (Integer)resp.get('plan_quantity');
    }
    
    public Integer getPlanUnitPrice(){
        return (Integer)resp.get('plan_unit_price');
    }
    
    public Integer getPlanSetupFee(){
        return (Integer)resp.get('setup_fee');
    }
    
    public String getCurCode(){
        return (String)resp.get('currency_code');
    }

}