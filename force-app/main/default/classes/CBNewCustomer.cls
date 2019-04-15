public with sharing class CBNewCustomer
{
    public  Contact  cont {get;set;}
    public  Account acct {get;set;}
    public CBNewCustomerUtil utilObj{get;set;}
    public String response{get;set;}
    
    public String action{get;set;}
    //public custom_field_config__c config{get;set;}
    public PageReference checkPermissions(){
        List<String> fields1 = new List<String> {'LastName', 'FirstName','Email', 'AccountId', 'Phone', 'MailingStreet', 'MailingCity', 'MailingState', 'MailingCountry', 'MailingPostalCode', 'Auto_collection__c', 'External_Id__c'};
        List<String> fields2 = new List<String> {'Name'};
        List<String> objNames = new List<String>();
        String fs;
        if(!FlsUtil.isPermitable(fields1,'contact')){
            fs = FlsUtil.getNotAccessibleFields(fields1,'contact','access');
            objNames.add('contact');   
        }
        if(!FlsUtil.isPermitable(fields2,'account')){
            fs += FlsUtil.getNotAccessibleFields(fields2,'account','access');
            objNames.add('account');   
        }
        System.debug('fs-----'+fs);
        if(fs==null)
        {
            return null;
        }
        else
            return redirectToError(fs,String.join(objNames,','));
    }
    
    public PageReference ToError()
    {
           PageReference pageRef = new PageReference('/apex/error');
           pageRef.setRedirect(true);
           return pageRef; 
    }
    public CBNewCustomer(){
        
        action = ApexPages.currentPage().getParameters().get('action');
    
        String cus_id = ApexPages.currentPage().getParameters().get('id');
        cus_id = String.escapeSingleQuotes(cus_id);
        
        //config = [select Customer_custom_map__c from custom_field_config__c];
        String que = 'select LastName, FirstName,Email, AccountId, Phone, MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Auto_collection__c, External_Id__c from contact where id=\''+cus_id+'\'';
        cont = Database.query(que);
        if(cont.AccountId != null){
            
            acct = [select Name from Account where id=:cont.AccountId];
        }
        
    }
    public PageReference redirectToError(String err,String obj){
       PageReference pageRef = new PageReference('/apex/error');
       pageRef.getParameters().put('err',err);
       pageRef.getParameters().put('obj',obj);
       pageRef.setRedirect(true);
       return pageRef; 
    }
    public PageReference createCustomer(){
        String ext_id = null;
        //String url = '/apex/CBNewCustomerUtil?id='+cont.id+'&action=create_cust';
        utilObj = new CBNewCustomerUtil();
        StatusClass.Status pr=utilObj.createCustomer(ApexPages.currentPage().getParameters().get('id'));
        
        System.debug('action---------'+action);
        System.debug('utilObj.response---'+utilObj.response);
        if(pr==StatusClass.Status.API_ERROR)
        {
           return null;
        }
        
        else if(pr==StatusClass.Status.ACCESSIBILITY_ERROR)
        {
            return ToError();
        }
        else
        {
        
            if(action=='sync')
            {
            //url = FlsUtil.safeUrl(url);        
            PageReference pageRef = new PageReference('/'+cont.id);
            pageRef.setRedirect(true);
            return pageRef;
            }
            else if(action=='update_payment_method')
            {
             PageReference pageRef = new PageReference('/apex/UpdatePaymentMethod');
             pageRef.getParameters().put('id',ApexPages.currentPage().getParameters().get('id'));
            pageRef.setRedirect(true);
            return pageRef;   
            }
            else if(action=='create_sub')
            {
                PageReference pageRef = new PageReference('/apex/New_subscription');
                pageRef.getParameters().put('con_id',ApexPages.currentPage().getParameters().get('id'));
                String opp_id = ApexPages.currentPage().getParameters().get('opp_id'); 
                if(opp_id != null && opp_id!='' && opp_id != 'null')
                {
                    pageRef.getParameters().put('opp_id',opp_id);
                }
                String id = ApexPages.currentPage().getParameters().get('id'); 
                if(id != null && id!='' && id != 'null')
                {
                    pageRef.getParameters().put('id',id);
                }
                pageRef.setRedirect(true);
                return pageRef;
            }
            else
                return null;
            
        }                        
     }
     
    public PageReference back(){        
            PageReference pageRef = new PageReference('/'+cont.id);
            pageRef.setRedirect(true);
            return pageRef;               
    } 
}