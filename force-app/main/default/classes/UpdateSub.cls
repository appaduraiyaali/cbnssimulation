public class UpdateSub{

    public Map<String,Object> mp{get;set;}
    public BaseEstimateController cont{get;set;}
    public String cbId{get;set;}
    
    public String oldPlan{get;set;}
    public String oldPlanCur{get;set;}
    public Integer oldPlanQuan{get;set;}
    public Integer oldPlanPrice{get;set;}
    public Integer oldPlanSetUp{get;set;}
    public String coupId{get;set;}
    public boolean invNow{get;set;}
    public List<SelectOption> optionsInvoiceNow{get;set;}
    
    public BaseError errObj{get;set;}
    public CB_Subscription__c sub{get;set;}

    public List<SelectOption> planOpts{
    get
    {
      List<PricebookEntry> prodList = new List<PricebookEntry>();
      prodList = [Select id,Product2.ExternalId,product2.name From PricebookEntry  where Pricebook2.Name='CB Standard' and product2.Status__c='ACTIVE' and product2.Product_Type__c='PLAN' limit 500];
      prodList.sort();
      planOpts = new List<SelectOption>();
      planOpts.add(new SelectOption('-1','Select'));
      for(PricebookEntry temp : prodList){
        if(temp.Product2.ExternalId!= null){
          planOpts.add(new SelectOption(temp.Product2.ExternalId,temp.Product2.name));
        }
      }
      planOpts = CBSubscriptionUtil.sortSelectOptions(planOpts);
      return planOpts;
    }
    set;
    }
    
    public List<SelectOption> coupenOptions {
    get{
      List<Coupon__c> prodList = new List< Coupon__c>();
      
      prodList = [Select Coupon_Id__c,Name,Status__c From Coupon__c where Status__c = 'ACTIVE' limit 500];
      coupenOptions = new List<SelectOption>();
      coupenOptions.add(new SelectOption('-1','Select'));
      for(Coupon__c temp : prodList){
        if(temp.Coupon_Id__c != null){
          coupenOptions.add(new SelectOption(temp.Coupon_Id__c,temp.name));
        }
      }
      coupenOptions = CBSubscriptionUtil.sortSelectOptions(coupenOptions);
      return coupenOptions;
    }
    set;
    }
    
    public UpdateSub(){
        
        sub = [select Id,CB_Id__c from CB_Subscription__c where Id=:'a0J2800000JDA7h'];
        if(sub.CB_Id__c==null){
            errObj = new BaseError('This subscription is not present in Chargebee.');
        }
        URLBuilder ub = new URLBuilder(EndPointsIndex.retrieve_sub_url);
        ub.ustring='gfdgd';
        cont = new RetSubController(ub);
        mp = cont.makeRequest();
        errObj = new BaseError(mp);
        SubRespObj subResp = new SubRespObj((Map<String,Object>)mp.get('subscription'));
        oldPlan=subResp.getPlanId();
        oldPlanCur=subResp.getCurCode();
        oldPlanPrice=subResp.getPlanUnitPrice();
        oldPlanQuan=subResp.getPlanQuan();
        oldPlanSetUp=subResp.getPlanSetupFee();
        coupId=subResp.getCouponId();
        optionsInvoiceNow = new List<SelectOption>();
        optionsInvoiceNow.add(new SelectOption('true','Invoice now'));
        optionsInvoiceNow.add(new SelectOption('false','Add to unbilled charges'));
        invNow=true;
        System.debug('coupId---'+coupId);       
    }
    
    public void start(){
    
         UpdateSubUrlBuilder usub = new UpdateSubUrlBuilder();
         usub.Id(cbId).planId('new1');
         cont = new UpdateSubEstController(usub);
         cont.setEndPoint(EndPointsIndex.update_est_url);
         mp = cont.makeRequest();
         
    }
}