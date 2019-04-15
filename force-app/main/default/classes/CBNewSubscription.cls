public with sharing class CBNewSubscription{

public String response {get;set;}
public Contact cont {get;set;}
public String con_id {get;set;}
public Integer pquan {get;set;}
public boolean sameBillAddress{get;set;}
public String planPrice{get;set;}
public String planCur{get;set;}
public String planSetupCost{get;set;}
public String msg{get;set;}
public Integer values{get;set;}
public Opportunity opp {get;set;}
public boolean checkout {get;set;}    
public List<AddonObject> selList {get;set;}  
public boolean invNow{get;set;}
public String bCycle{get;set;}
public DateTime sDate{get;set;}
public String plans{get;set;}
public String coupen{get;set;}
public String ponum{get;set;}
public String sState{get;set;}
public String sCity{get;set;}
public String sCountry{get;set;}
public String sAddress1{get;set;}
public String sAddress2{get;set;}
public String sAddress3{get;set;}
public String sPhone{get;set;}
public String sCompany{get;set;}
public String sFname{get;set;}
public String sDateStr{get;set;}
public String sLname{get;set;}
public String sZipcode{get;set;}
public String sEmail{get;set;}
public String opp_id{get;set;}
public String opp_name{get;set;}
public List<SelectOption> optionsAuto{get;set;}
public List<SelectOption> optionsCountry{get;set;}
public List<SelectOption>  optionsInvoiceNow{get;set;}
public CBURLUtil urlUtil{get;set;}
public String autocol{get;set;}
public boolean showPopup{get;set;}
public PricebookEntry sltd{get;set;}
public String status{get;set;}
public Long nextbillat{get;set;}
public List<LineItem> lts{get;set;}
public Double disc_amt{get;set;} 
public String disc_desc{get;set;}
public String cc{get;set;}
public Double tot{get;set;}
public Double subt{get;set;}
public String displayText{get;set;}
public String tabName{get;set;}
public boolean stdate{get;set;}
public boolean tab{get;set;}
public String selectedTab{get;set;}
public boolean tab1{get;set;}
public String subId{get;set;}
//
public boolean error{get;set;}
public String style{get;set;}
public String tabStyle1{get;set;}
public String tabStyle2{get;set;}
public boolean disc{get;set;}

public PageReference checkPermissions(){
        List<String> fields1 = new List<String> {'LastName', 'FirstName','Email', 'AccountId', 'Phone', 'MailingStreet', 'MailingCity', 'MailingState', 'MailingCountry', 'MailingPostalCode', 'Auto_collection__c', 'External_Id__c'};
        List<String> fields2 = new List<String> {'ExternalId','name','Recurring_charge_model__c','Addon_Type__c','Currency__c','Status__c','Product_Type__c'};
        List<String> fields3 = new List<String> {'Id','name','Setup_Cost__c','UnitPrice'};
        
        List<String> fields4 = new List<String> {'Coupon_Id__c','Name','Status__c'};
        List<String> fields5 = new List<String>{'Name','Id', 'AccountId'};
        List<String> fields6 = new List<String> {'Name'};
        List<String> objNames = new List<String>();
        String fs;
        if(!FlsUtil.isPermitable(fields1,'contact')){
            fs = FlsUtil.getNotAccessibleFields(fields1,'contact','access');
            objNames.add('contact');   
        }
        if(!FlsUtil.isPermitable(fields2,'product2')){
            fs += FlsUtil.getNotAccessibleFields(fields2,'product2','access');
            objNames.add('product2');   
        }
        if(!FlsUtil.isPermitable(fields3,'pricebookentry')){
            fs += FlsUtil.getNotAccessibleFields(fields3,'pricebookentry','access');
            objNames.add('pricebookentry');   
        }
        if(!FlsUtil.isPermitable(fields4,'Coupon__c')){
            fs += FlsUtil.getNotAccessibleFields(fields4,'Coupon__c','access');
            objNames.add('Coupon__c');   
        }
        if(!FlsUtil.isPermitable(fields5,'opportunity')){
            fs += FlsUtil.getNotAccessibleFields(fields5,'opportunity','access');
            objNames.add('opportunity');   
        }
        
        if(!FlsUtil.isPermitable(fields6,'Pricebook2')){
            fs += FlsUtil.getNotAccessibleFields(fields6,'Pricebook2','access');
            objNames.add('Pricebook2');   
        }
        System.debug('fs-----'+fs);
        if(fs==null)
        {
            return null;
        }
        else
            return redirectToError(fs,String.join(objNames,','));
    }
public PageReference preview(){
    showPopup=true;
    populate(); 
    return null;
}
public void selecttab(){
        tabStyle1='cb-btn cb-btn--selected';
        tabStyle2='cb-btn cb-btn--righttab';
        tab1 = true;
}
public void selecttab1(){
    tabStyle2='cb-btn cb-btn--selected';
    tabStyle1='cb-btn cb-btn--lefttab';
    tab1 = false;
    ApexPages.currentPage().getParameters().put('con_id',ApexPages.currentPage().getParameters().get('con_id'));
    ApexPages.currentPage().getParameters().put('opp_id',ApexPages.currentPage().getParameters().get('opp_id'));   
}

public void populate(){
        String responseFromNet;
        response=null;
        String endpointURL = CBSubscriptionUtil.getEstimateEndPoint(urlUtil, cont.External_Id__c);
        String bodyData = '';
        if(subId != null && !subId.equals('')){
                bodyData = CBURLUtil.buildURLString(bodyData,'subscription[id]',subId.trim());
        }
        bodyData = CBURLUtil.buildURLString(bodyData, 'subscription[plan_id]', plans);
        bodyData = CBURLUtil.buildURLString(bodyData,'subscription[plan_quantity]',String.valueOf(pquan));
        stdate = false;
        System.debug('sDateStr----'+sDateStr);
        if(sDateStr!=null && !sDateStr.equals('')){
            sDateStr += ':00';
            stdate = true;
        }
        System.debug('sDateStr-->>'+sDateStr);
        long milli = CBSubscriptionUtil.getSubscriptionStartDate(sDateStr).getTime();
        bodyData = CBURLUtil.buildURLString(bodyData,'billing_cycles',bCycle);
        bodyData = CBURLUtil.buildURLString(bodyData,'auto_collection',autocol);
        bodyData = CBURLUtil.buildURLString(bodyData,'po_number',ponum);
        if(coupen !=null && !coupen.equals('') && !coupen.equals('-1')){
            bodyData = CBURLUtil.buildURLString(bodyData,'coupon_ids[0]',coupen);
        }
        if( canOverRide ){
            if(planPrice != null && !planPrice.equals('')){
                try{
                    bodyData = CBURLUtil.buildURLString(bodyData,'subscription[plan_unit_price]',String.valueOf(ChargebeeUtil.convertToLowerOrderCurrency(planCur,Double.valueOf(planPrice))));
                }
                catch(Exception e){
                    showPopup=false;
                    response=e.getMessage();
                    error=true;
                    return;
                }
                    
            }
            if(planSetupCost != null&& !planSetupCost.equals('')){
                try{
                    bodyData = CBURLUtil.buildURLString(bodyData,'subscription[setup_fee]',String.valueOf(ChargebeeUtil.convertToLowerOrderCurrency(planCur,Double.valueOf(planSetupCost))));
                }catch(Exception e){
                    showPopup=false;
                    response=e.getMessage();
                    error=true;
                    return;
                }
            }
        }
        
        if(sameBillAddress == false)
        {
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[first_name]',sFname);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[last_name]',sLname);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[email]',sEmail);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[phone]',sPhone);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[company]',sCompany);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[line1]',sAddress1);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[line2]',sAddress2);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[line3]',sAddress3);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[city]',sCity);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[state]',sState);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[country]',sCountry);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[zip]',sZipcode);   
        }
        
        bodyData = CBSubscriptionUtil.getAddonURL(selList,bodyData, PlanExternalIdVsChargeModel, canOverRide);
        endpointURL = endpointURL+bodyData;
        responseFromNet = CBURLUtil.sendRequest(endpointURL, null, urlUtil, true, 'GET');
        
        Map<String, Object> responseMap = CBURLUtil.convertMap(responseFromNet);
        try
        { 
                Map<String, Object> estimate = (Map<String, Object>)responseMap.get('estimate');
                Map<String, Object> subEstimate = (Map<String, Object>)estimate.get('subscription_estimate');
                String jst = (String)subEstimate.get('status');
                Map<String, Object> invEst = null;
                Map<String,Object> est = (Map<String,Object>)estimate.get('estimate');
                invEst = (Map<String, Object>)estimate.get('invoice_estimate');
                if(invEst==null){
                    invEst = (Map<String, Object>)estimate.get('next_invoice_estimate');
                }
                List<Object> lineItems = new List<Object>();
                lineItems = (List<Object>)invEst.get('line_items');
               
                subt = ChargebeeUtil.convertToHigherOrderCurrency(cc,Integer.valueOf(invEst.get('amount_due')));
                tot = ChargebeeUtil.convertToHigherOrderCurrency(cc,Integer.valueOf(invEst.get('total')));
                cc = (String)subEstimate.get('currency_code');
                long lv=0;
                
                for(Object lt:lineItems){
                    String unitAmount = String.valueOf(((Map<String, Object>)lt).get('unit_amount'));
                    String quantity =   String.valueOf(((Map<String, Object>)lt).get('quantity'));
                    String amt = String.valueOf(((Map<String, Object>)lt).get('amount'));
                    String descrip = String.valueOf(((Map<String, Object>)lt).get('description'));
                    String et = String.valueOf(((Map<String, Object>)lt).get('entity_type'));
                    String e_id = String.valueOf(((Map<String, Object>)lt).get('entity_id'));
                    String recur_type = PlanExternalIdVsChargeModel.get(e_id+'_CHARGE_MODEL');
                    
                    boolean ir=true;
                    if(et=='plan_setup')
                    {
                     ir=false;   
                    }
                    if(recur_type!=null)
                    {
                        if(recur_type=='NON_RECURRING')
                        {
                            ir=false;
                        }
                    }
                    LineItem  linet = new LineItem(unitAmount,quantity,descrip,amt,cc,et,ir);
                    lts.add(linet);
                }
                if(jst=='in_trial')
                {
                    displayText= CBSubscriptionUtil.getImmediateChargeDisplayText(cc,sDate, tot);
                    status = 'in_trial';
                    tabName = 'CHARGES ON ACTIVATION';
                    tab=true;
                    style += ' cb-status--trial';
                }
                else
                {
                if(invNow)
                {
                    if(stdate)
                    {
                        displayText= CBSubscriptionUtil.getImmediateChargeDisplayText(cc,sDate, tot);
                        tabName = 'CHARGES ON ACTIVATION';
                        status = 'future';
                        tab=true;
                        style += ' cb-status--future';
                    }
                    else
                    {
                        displayText= CBSubscriptionUtil.getInvDisplayText(cc,tot);
                        tabName = 'IMMEDIATE CHARGES';
                        status='active';
                        tab=true;
                    }
                
                }
                else
                {
                    if(stdate)
                    {
                        displayText= CBSubscriptionUtil.getNoChargeDisplayText();
                        tabName = 'false';
                        tab=false;
                        status = 'future';
                        style += ' cb-status--future';
                    }
                    else
                    {
                        displayText= CBSubscriptionUtil.getNoChargeWithTotDisplayText(cc,tot);
                        tabName = 'UNBILLED CHARGES';
                        status='active';
                        tab=true;
                    
                    }
                
                }
                }
                List<Object> discounts =null;
                if(invEst!=null){
                    discounts = (List<Object>)invEst.get('discounts');
                }
                if(discounts!=null){
                    Integer sl = (Integer)((Map<String, Object>)discounts[0]).get('amount');
                    System.debug('sl-->>'+sl);
                    disc=true;
                    long l = (long)(sl);        
                    System.debug('l-->>'+l);
                    disc_amt = ChargebeeUtil.convertToHigherOrderCurrency(cc,l); 
                    disc_desc = (String)((Map<String, Object>)discounts[0]).get('description');   
                }
        }
        catch(Exception ex)
        {
            showPopup=false;
            response=(String)responseMap.get('type')+' - '+(String)responseMap.get('message');
            error=true;
        }
        System.debug('error--->>>'+error);
        System.debug('response--->>>'+response);
}

public PageReference save(){       
        String is_error =null;
        String responseFromNet;
        
        string endpointURL = CBSubscriptionUtil.getCreateSubscriptionEndPoint(urlUtil, cont.External_Id__c);
        String bodyData = 'plan_id='+EncodingUtil.urlEncode(plans,'UTF-8');
        if(subId != null && !subId.equals('')){
                bodyData = CBURLUtil.buildURLString(bodyData,'id',subId.trim());
        }
        bodyData = CBURLUtil.buildURLString(bodyData,'plan_quantity',String.valueOf(pquan));
        
        long milli = CBSubscriptionUtil.getSubscriptionStartDate(sDateStr).getTime();
        bodyData = CBURLUtil.buildURLString(bodyData,'start_date',String.valueOf(milli/1000));
        bodyData = CBURLUtil.buildURLString(bodyData,'billing_cycles',bCycle);
        bodyData = CBURLUtil.buildURLString(bodyData,'auto_collection',autocol);
        bodyData = CBURLUtil.buildURLString(bodyData,'invoice_immediately',CBURLUtil.boolToString(invNow));
        bodyData = CBURLUtil.buildURLString(bodyData,'po_number',ponum);
        if(coupen !=null && !coupen.equals('') && !coupen.equals('-1')){
            bodyData = CBURLUtil.buildURLString(bodyData,'coupon_ids[0]',coupen);
        }
        if( canOverRide ){
            if(planPrice != null && !planPrice.equals('')){
                bodyData = CBURLUtil.buildURLString(bodyData,'plan_unit_price',String.valueOf(ChargebeeUtil.convertToLowerOrderCurrency(planCur,Double.valueOf(planPrice))));
            }
            if(planSetupCost != null && !planSetupCost.equals('')){
                bodyData = CBURLUtil.buildURLString(bodyData,'setup_fee',String.valueOf(ChargebeeUtil.convertToLowerOrderCurrency(planCur,Double.valueOf(planSetupCost))));
            }
        }
        
        if(sameBillAddress == false)
        {   
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[first_name]',sFname);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[last_name]',sLname);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[email]',sEmail);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[phone]',sPhone);
            bodyData = CBURLUtil.buildURLString(bodyData,'company',sCompany);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[line1]',sAddress1);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[line2]',sAddress2);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[line3]',sAddress3);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[city]',sCity);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[state]',sState);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[country]',sCountry);
            bodyData = CBURLUtil.buildURLString(bodyData,'shipping_address[zip]',sZipcode);                                                                                         
        }
        bodyData = CBSubscriptionUtil.getAddonURL(selList,bodyData, PlanExternalIdVsChargeModel, canOverRide);
        System.debug('bodyData---' + bodyData);       
        
        try 
        {
            responseFromNet = CBURLUtil.sendRequest(endpointURL, bodyData, urlUtil, true);    
        }
        catch(Exception exp)
        {
            responseFromNet = 'CB Exception-'+exp;
            response  = responseFromNet;
            is_error = response;
        }   
        if(is_error !=null )
        {return null;}

        String sub_id = CBURLUtil.getIdFromResponse(responseFromNet);
            System.debug('sub_id--' + sub_id);
            bodyData = CBURLUtil.buildURLString(bodyData, 'entity_id',sub_id);
            if(sub_id != null && sub_id != '')
            {  
                String updateTPEndpoint = CBSubscriptionUtil.getUpdateTPEndPoint(urlUtil);
                try {
                    bodyData = CBSubscriptionUtil.getDataForTpSync(opp_id, bodyData);
                    responseFromNet = CBURLUtil.sendRequest(updateTPEndpoint, bodyData, urlUtil, true);
                    response=null;
                }catch(Exception exp){
                    responseFromNet = 'CB Exception '+exp;
                    response = responseFromNet;
                    is_error=response;
                }
                 
            }
            else
            {
                response = responseFromNet;
                return null;
            }
        
        System.debug('is_error--' + is_error);
        System.debug('sub_id--'+sub_id);
        
        if(is_error!=null)
        {
            return null;
        }else{
            if( sub_id != null ){
                String subSyncEndPoint = CBSubscriptionUtil.getSyncSubsEndPoint(urlUtil);
                bodyData = '';
                bodyData = CBURLUtil.buildURLString(bodyData, 'id', sub_id);
                bodyData = CBURLUtil.buildURLString(bodyData,'api_key',urlUtil.getApiKey());
               try 
                    {
                        responseFromNet = CBURLUtil.sendRequest(subSyncEndPoint, bodyData, urlUtil, true);
                        System.debug('tp responseFromNet--' + responseFromNet);
                        response=null;
                    }catch(Exception exp){
                        System.debug('exception '+exp);
                        responseFromNet = 'CB Exception '+exp;
                    } 
            }
        }

        return page_redirect();
}

public PageReference page_redirect(){
    String url = con_id;
    if(opp_id !=null && opp_id != '-1'){url=opp_id;}
    PageReference pageRef = new PageReference('/'+url);
    pageRef.setRedirect(true);
    return pageRef;
}

public PageReference cancel_page(){
    return page_redirect();
}

public PageReference checkout(){
        String responseFromNet;
        string endpointURL = CBSubscriptionUtil.getCheckoutURL(urlUtil);
        String bodyData = '';
        bodyData = CBURLUtil.buildURLString(bodyData, 'customer[id]', cont.External_Id__c);
        if(subId != null && !subId.equals('')){
                bodyData = CBURLUtil.buildURLString(bodyData,'subscription[id]',subId.trim());
        }
        bodyData=CBURLUtil.buildURLString(bodyData,'subscription[plan_id]',EncodingUtil.urlEncode(plans,'UTF-8'));
        bodyData = CBURLUtil.buildURLString(bodyData,'subscription[plan_quantity]', String.valueOf(pquan));       
        long milli = CBSubscriptionUtil.getSubscriptionStartDate(sDateStr).getTime();
        bodyData = CBURLUtil.buildURLString(bodyData,'subscription[start_date]',String.valueOf(milli/1000));
        bodyData = CBURLUtil.buildURLString(bodyData,'billing_cycles',bCycle);
        bodyData = CBURLUtil.buildURLString(bodyData,'subscription[auto_collection]',autocol);    
        bodyData = CBURLUtil.buildURLString(bodyData,'po_number',ponum);
        
        if(coupen !=null && !coupen.equals('') && !coupen.equals('-1')){
            bodyData = CBURLUtil.buildURLString(bodyData,'subscription[coupon]',coupen);
        }
        if( canOverRide ){
            if(planPrice != null && !planPrice.equals('')){
            bodyData = CBURLUtil.buildURLString(bodyData,'subscription[plan_unit_price]',String.valueOf((ChargebeeUtil.convertToLowerOrderCurrency(planCur,Double.valueOf(planPrice)))));
            }
            if(planSetupCost != null && !planSetupCost.equals('')){
            bodyData = CBURLUtil.buildURLString(bodyData,'subscription[setup_fee]',String.valueOf((ChargebeeUtil.convertToLowerOrderCurrency(planCur,Double.valueOf(planSetupCost)))));
            }
        }
        bodyData = CBSubscriptionUtil.getAddonURL(selList,bodyData, PlanExternalIdVsChargeModel, canOverRide);
        
        try {
            responseFromNet = CBURLUtil.sendRequest(endpointURL, bodyData, urlUtil, true, 'POST');
        }
        catch(Exception exp){
            System.debug('exception '+exp);
            responseFromNet = 'exception '+exp;
        }   
        response = responseFromNet+' '+bodyData;
        String link = CBURLUtil.getValueFromResponse(responseFromNet, 'url');
        String uid = CBURLUtil.getValueFromResponse(responseFromNet, 'id');        
        response = responseFromNet+'  res = '+link;
        if(link==null){
            return null;
        }
        PageReference pageRef = new PageReference('/apex/CBCheckoutLink?id='+cont.id+'&link_url='+link+'&link_id='+uid);
        pageRef.setRedirect(true);
        System.debug('pageRef--' + pageRef);
        return pageRef;
}

public PageReference Cancel(){
        showPopup = false;
        PageReference pr = new PageReference('/apex/New_subscription');
        pr.getParameters().put('con_id',ApexPages.currentPage().getParameters().get('con_id'));
        pr.getParameters().put('opp_id',ApexPages.currentPage().getParameters().get('opp_id'));
        system.debug('opp_id-->'+ApexPages.currentPage().getParameters().get('opp_id'));
        pr.setRedirect(true);
        return pr;
}

public List<SelectOption> options3{
get
{
   
     
  List<PricebookEntry> prodList = new List<PricebookEntry>();
  prodList = [Select id,Product2.ExternalId,product2.name From PricebookEntry  where Pricebook2.Name='CB Standard' and product2.Status__c='ACTIVE' and product2.Product_Type__c='PLAN' limit 500];
  prodList.sort();
  options3 = new List<SelectOption>();
  options3.add(new SelectOption('-1','Select'));
  for(PricebookEntry temp : prodList){
    if(temp.Product2.ExternalId!= null){
      options3.add(new SelectOption(temp.Product2.ExternalId,temp.Product2.name));
    }
  }
  options3 = CBSubscriptionUtil.sortSelectOptions(options3);
  return options3;
}
set;}

public PageReference redirectToError(String err,String obj){
       PageReference pageRef = new PageReference('/apex/error');
       pageRef.getParameters().put('err',err);
       pageRef.getParameters().put('obj',obj);
       pageRef.setRedirect(true);
       return pageRef; 
    }


public Map<String,String> PlanExternalIdVsChargeModel{
get
{
  List<PricebookEntry> prodList = new List<PricebookEntry>();
  
  prodList = [Select id,Product2.ExternalId,product2.Recurring_charge_model__c,product2.Addon_Type__c,product2.Product_Type__c,PricebookEntry.Setup_Cost__c,PricebookEntry.UnitPrice, product2.Currency__c From PricebookEntry  where Pricebook2.Name='CB Standard' and product2.Status__c='ACTIVE' and (product2.Product_Type__c='PLAN' or product2.Product_Type__c='ADDON') limit 500];
  PlanExternalIdVsChargeModel = new Map<String,String>();
  
  for(PricebookEntry temp : prodList)
  {
    if(temp.Product2.Product_Type__c == 'PLAN' && temp.Product2.ExternalId!= null)
    {
      PlanExternalIdVsChargeModel.put(temp.Product2.ExternalId+'_CHARGE_MODEL',temp.Product2.Recurring_charge_model__c);
    }
    else if(temp.Product2.Product_Type__c == 'ADDON' && temp.Product2.ExternalId!= null
                && temp.Product2.Addon_Type__c != null ){
        PlanExternalIdVsChargeModel.put(temp.Product2.ExternalId+'_CHARGE_MODEL',temp.Product2.Addon_Type__c);
    }
    PlanExternalIdVsChargeModel.put(temp.Product2.ExternalId+'_UNIT_PRICE',String.valueOf(temp.UnitPrice));

    if( temp.Setup_Cost__c != null ){
        PlanExternalIdVsChargeModel.put(temp.Product2.ExternalId+'_SETUP_COST',String.valueOf(temp.Setup_Cost__c));
    }
    if( temp.Product2.Currency__c!= null ){
        PlanExternalIdVsChargeModel.put(temp.Product2.ExternalId+'_CURRENCY',String.valueOf(temp.Product2.Currency__c));
    }
  }
  return PlanExternalIdVsChargeModel;
}
set;
}

public String JsonMap{get{
      JsonMap = JSON.serialize(PlanExternalIdVsChargeModel);
      return JsonMap;
}set;
}

public Boolean canOverride{
    get{
        return urlUtil.canOverRide();
    }set;
}

public List<SelectOption> addonOptions{
get
{
  List<PricebookEntry> prodList = new List<PricebookEntry>();
  
  
  prodList = [Select id,Product2.ExternalId,product2.name,product2.Product_Type__c From PricebookEntry  where Pricebook2.Name='CB Standard' and product2.Status__c='ACTIVE' and product2.Product_Type__c='ADDON' limit 500];
  addonOptions = new List<SelectOption>();
  addonOptions.add(new SelectOption('-1','Select'));
  System.debug('prodList-->>'+prodList);
  
  for(PricebookEntry temp : prodList)
  {
    if(temp.Product2.ExternalId!= null)
    {
      addonOptions.add(new SelectOption(temp.Product2.ExternalId,temp.Product2.name));
    }
  }
  addonOptions = CBSubscriptionUtil.sortSelectOptions(addonOptions);
  return addonOptions;
}
set;
}

public List<SelectOption> oppOptions {get;set;}

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

public PageReference updateStartDate(Date val){
  sDate=val;
  return null;
}

public PageReference saveAccount(){
  sameBillAddress = !sameBillAddress;
  return null;
}

    public PageReference saveAddons(){
        Integer i = values;
        AddonObject ax = new AddonObject('-1',1,i+1,0);
        ax.setStatus(2);
        selList.add(ax);
        AddonObject old = selList.get(i-1);
        old.setStatus(3);
        return null;
    }
    
    public PageReference delAddons(){
        Integer i = values;
        AddonObject old = selList.get(i-1);
        old.setStatus(4);
        return null;
    }   
    
    
    
  public CBNewSubscription()
  {
      showPopup=false;
      bCycle=null;
      sameBillAddress = true;
      sDate=null;
      invNow=true;
      urlUtil = new CBURLUtil();
      autocol = urlUtil.autoCollectionFlag();
      optionsAuto = new List<SelectOption>();
      optionsAuto.add(new SelectOption('OFF','OFF'));      
      optionsAuto.add(new SelectOption('ON','ON'));
      sltd = new PricebookEntry();
      optionsInvoiceNow = new List<SelectOption>();
      optionsInvoiceNow.add(new SelectOption('true','Invoice now'));
      optionsInvoiceNow.add(new SelectOption('false','Add to unbilled charges'));    
      lts = new List<LineItem>();
      selectedTab ='NewSubscriptionPreview';
      tab1=true;
      error=false;
      con_id = ApexPages.currentPage().getParameters().get('con_id'); 
      
      con_id = String.escapeSingleQuotes(con_id);
      String que = 'select Account.Name,Name,LastName, FirstName,Email, AccountId, Phone, MobilePhone, MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Auto_collection__c, External_Id__c from contact where id=\''+con_id+'\'';
      cont=Database.query(que); 
      selList = new List<AddonObject>();
      AddonObject ax = new AddonObject('-1',1,1,0);
      ax.setStatus(2);
      selList.add(ax);
      style = 'cb-status';
      opp_id = ApexPages.currentPage().getParameters().get('opp_id');

      tabStyle1='cb-btn cb-btn--selected';
      tabStyle2='cb-btn cb-btn--righttab';
      
      if(opp_id == null || opp_id == 'null' || opp_id == '-1'){
          List<Opportunity> oppList = new List<Opportunity>();
          
          oppList = [select id,name from Opportunity where AccountId=:cont.AccountId];
          oppOptions =  new List<SelectOption>();
          oppOptions.add(new SelectOption('-1','Select'));
          for(Opportunity temp : oppList){
            if(temp.id != null){
              oppOptions.add(new SelectOption(temp.id,temp.name));
            }
          }              
      }
      else{
        
        opp_id = String.escapeSingleQuotes(opp_id);
        String que2 = 'select id,name from Opportunity where Id=\''+opp_id+'\'';
        Opportunity opptemp = Database.query(que2);
        opp_name = opptemp.name;
      }
      optionsCountry = ChargebeeUtil.getCountrySelectOptions();
      pquan=1;
  }
  
 }