public class ListUnbilledChargesController{
    public String con_id{get;set;}
    public String err_msg{get;set;}
    public CBURLUtil urlUtil{get;set;}
    public ListUnbilledCharges luc{get;set;}
    public String sub{get;set;}
    public Boolean showPopup{get;set;}
    public Contact cont{get;set;}
    public InvoiceUnbilledEstimate unbilledEst{get;set;}
    public Boolean empty{get;set;}
    public Boolean iserr{get;set;}
    public String emsg{get;set;}
    
    public ListUnbilledChargesController(){
      iserr=false;
      con_id = ApexPages.currentPage().getParameters().get('con_id');
      urlUtil = new CBURLUtil();
      String que = 'select Id,Email,External_Id__c from contact where Id=\''+con_id+'\'';
      cont=Database.query(que);
      if(cont.External_Id__c==null){
          err_msg='This customer is not present in chargebee.';
          empty=true;
      }else{
          String endpointURL = CBSubscriptionUtil.getListUnbilledChargesEndPoint(urlUtil);
          String bodyData='';
          bodyData = CBURLUtil.buildURLString(bodyData,'customer_id[is]',cont.External_Id__c);
          endpointURL = endpointURL+'?'+bodyData;
          String response = CBURLUtil.sendRequest(endpointURL,null,urlUtil,true,'GET');
          System.debug('response-'+response);
          System.debug('cont.External_Id__c---'+cont.External_Id__c);
          luc = new ListUnbilledCharges(response);
          
          if(luc.jsonMap.get('list')!=null){
              empty=((List<Object>)luc.jsonMap.get('list')).isEmpty();
              if(empty){
              err_msg='No unbilled charges found for this customer.';
              }
              else{
              if(luc.isAllVoided()){
                  err_msg='All unbilled charges are voided for this customer.';
                  empty=true;
              }
          }
          }
          if(luc.isErrorResponse){
              err_msg=response;
              empty=true;
          }
          
          
      }
      
    }
    
    public PageReference preview(){
        showPopup=true;
        populate(); 
        return null;
    }
    
    public void populate(){
          String endpointURL = CBSubscriptionUtil.getUnbilledChargesEstimateEndPoint(urlUtil);
          String bodyData='';
          bodyData = CBURLUtil.buildURLString(bodyData,'customer_id',cont.External_Id__c);
          String response = CBURLUtil.sendRequest(endpointURL,bodyData,urlUtil,true,'POST');
          unbilledEst = (InvoiceUnbilledEstimate)EstimateFactory.constructResponseObject(response,'unbilled_estimate');
          
    }
    
    
    public PageReference Save(){
              String endpointURL = CBSubscriptionUtil.getInvoiceUnbilledChargesEndPoint(urlUtil);
              String bodyData='';
              bodyData = CBURLUtil.buildURLString(bodyData,'customer_id',cont.External_Id__c);
              String response = CBURLUtil.sendRequest(endpointURL,bodyData,urlUtil,true,'POST');
              System.debug('response--'+response);
              Map<String,Object> jsonMap=(Map<String,Object>)JSON.deserializeUntyped(response);
              if(jsonMap.get('invoices')!=null){
                  return backToContact();
              }
              else{
                  iserr=true;
                  if(jsonMap.get('error_msg')!=null){
                      emsg=(String)jsonMap.get('error_msg');
                  }
                  else
                      emsg='CB Internal Error';
                  return null;
              }    
              
    }
    
    public PageReference backToContact(){
        return new PageReference('/'+con_id);
        
    }
    
    public PageReference Cancel(){
        PageReference pr = new PageReference('/apex/list_unbilled_charges');
        pr.getParameters().put('con_id',ApexPages.currentPage().getParameters().get('con_id'));
        pr.setRedirect(true);
        return pr;
    
    }
    
}