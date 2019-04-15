public with sharing class AddCharge
{
    public String amount{get;set;}
    public String description{get;set;}
    public String invoiceOpt{get;set;}
    public List<SelectOption> invoiceOptList{get;set;}
    public CBURLUtil urlUtil{get;set;}
    private String subscriptionId;
    public String responseFromNet{get;set;}
    public Product2[] p{get;set;}
    
    public PageReference checkPermissions(){
        List<String> fields1 = new List<String> {'Id','Currency__c'};
        List<String> fields2 = new List<String> {'Subscription_Plan__c'};
        List<String> objNames = new List<String>();
        String fs;
        if(!FlsUtil.isPermitable(fields1,'product2')){
            fs = FlsUtil.getNotAccessibleFields(fields1,'product2','access');
            objNames.add('product2');   
        }
        if(!FlsUtil.isPermitable(fields2,'CB_Subscription__c')){
            fs += FlsUtil.getNotAccessibleFields(fields2,'CB_Subscription__c','access');
            objNames.add('CB_Subscription__c');   
        }
        System.debug('fs-----'+fs);
        if(fs==null)
        {
            return null;
        }
        else
            return redirectToError(fs,String.join(objNames,','));
    }
    public AddCharge(){
        urlUtil = new CBURLUtil(); 
        invoiceOptList = new List<SelectOption>();
        invoiceOptList.add(new SelectOption('ADD_UNBILLED_CHARGE','Add to Unbilled Charges'));                
        invoiceOptList.add(new SelectOption('INVOICE_NOW','Invoice Now'));
        List<String> fields1 = new List<String> {'Id','Currency__c'};
        List<String> fields2 = new List<String> {'Subscription_Plan__c'};
        
            p=[select Id,Currency__c from Product2 where Id in (select Subscription_Plan__c from CB_Subscription__c)];
        
        
    }
    
    public PageReference redirectToError(String err,String obj){
       PageReference pageRef = new PageReference('/apex/error');
       pageRef.getParameters().put('err',err);
       pageRef.getParameters().put('obj',obj);
       pageRef.setRedirect(true);
       return pageRef; 
    }

    public PageReference save(){
        
        subscriptionId = ApexPages.currentPage().getParameters().get('sub_id');
        System.debug('subscriptionId---' + subscriptionId);
        string endpointURL = urlUtil.getUrl()+'/api/v2/invoices/charge';
        String bodyData = '';
           
        if(invoiceOpt.equals('ADD_UNBILLED_CHARGE')){
            endpointURL = urlUtil.getUrl()+'/api/v2/subscriptions/' + EncodingUtil.urlEncode(subscriptionId,'UTF-8') + '/add_charge_at_term_end';
        }else{
            bodyData = CBURLUtil.buildURLString(bodyData,'subscription_id',subscriptionId);
        }
        Integer amountInt = Integer.valueOf(amount);
        System.debug('amountInt---' + amountInt);
        amountInt *= 100;
        
        bodyData = CBURLUtil.buildURLString(bodyData, 'amount', String.valueOf(amountInt));
        bodyData = CBURLUtil.buildURLString(bodyData, 'description', description);
        
        System.debug('endpointURL--' + endpointURL);
        System.debug('Amount is '+ amountInt +'. Description is '+this.Description+'. Option is '+this.invoiceOpt);
        
        try{
            responseFromNet = CBURLUtil.sendRequest(endpointURL, bodyData, urlUtil, true);
        }
        catch(Exception exp){
            System.debug('exception '+exp);
            responseFromNet = 'Error-' + exp;
            return null;
        }        
        String id = CBURLUtil.getIdFromResponse(responseFromNet);
        System.debug('responseFromNet--' + responseFromNet);
        if( id == null ){
            return null;
        }
        responseFromNet = '';
        
        return new PageReference('/' + ApexPages.currentPage().getParameters().get('pk'));

    }
}