public with sharing class RedirectToChargebee{
    public String sub_id{get;set;}    
    public CBURLUtil urlUtil{get;set;}
    public CB_Subscription__c subObj{get;set;}
    public Set<String> whiteListedDomains{get;set;}
    
    public RedirectToChargebee(){
        whiteListedDomains = new Set<String>();
        urlUtil = new CBURLUtil();
        String url = urlUtil.getUrl()+'/admin-console/subscriptions/';
        whiteListedDomains.add(url);
    }
    
    public PageReference redirectToError(){
           PageReference pageRef = new PageReference('/apex/error');
           pageRef.setRedirect(true);
           return pageRef; 
    }
    
    public PageReference setSubId(){
            String subParamId = ApexPages.currentPage().getParameters().get('sub_id');
            List<String> fields = new List<String> {'CB_Id__c'};
            if(!FlsUtil.isPermitable(fields,'CB_Subscription__c'))
            {
                return redirectToError();
            }
            subParamId = String.escapeSingleQuotes(subParamId);
            String que = 'select CB_Id__c from CB_Subscription__c where Id=\''+subParamId+'\'';
            //subObj = [select CB_Id__c from CB_Subscription__c where Id=:subParamId];
            System.debug('query string -' + que);
            subObj = Database.query(que);
            String url =  urlUtil.getUrl()+'/admin-console/subscriptions/';
                if(!whiteListedDomains.contains(url))
                {
                     url = '/home/home.jsp';
                     return new PageReference(url);   
                }
            sub_id = url + subObj.CB_Id__c;
            return new PageReference(sub_id);
    }
    public PageReference back(){
           PageReference pageRef = new PageReference('/'+ApexPages.currentPage().getParameters().get('sub_id'));
           pageRef.setRedirect(true);
           return pageRef;
    }
}