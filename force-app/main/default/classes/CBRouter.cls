public with sharing class CBRouter
{
    public String acc_id {get;set;}
    public String con_id {get;set;}
    public String opp_id {get;set;}
    public List<SelectOption> options3 {get;set;}
    //public String action {get;set;}
    public String from_page {get;set;}
    public String id {get;set;}
    public CBURLUtil util{get;set;}
    
    public PageReference createSubscription()
    {
           if(isUpdate(con_id)){
                //redirect to create subscription
                String url = FlsUtil.getUrlMap().get('create_subscription_con');
                url = url +'?con_id='+con_id;
                url = FlsUtil.safeUrl(url);
                PageReference pageRef = new PageReference('/'+url);
                //pageRef.getParameters.put('link_url', link);
                if(opp_id!=null)
                {
                    pageRef.getParameters().put('opp_id',opp_id);
                }
                pageRef.setRedirect(true);
                return pageRef;
            }
            else
            {
               String url = '/apex/CBNewCustomer?id='+con_id+'&action=create_sub&con_id='+con_id;
               if(opp_id!=null){url=url+'&opp_id='+opp_id;}
               url = FlsUtil.safeUrl(url);
               PageReference pageRef = new PageReference('/'+url);
               if(opp_id!=null)
                {
                    pageRef.getParameters().put('opp_id',opp_id);
                }
               pageRef.setRedirect(true);
               return pageRef; 
           }
    }
    
    public CBRouter()
    {
        from_page = ApexPages.currentPage().getParameters().get('from');
        id = ApexPages.currentPage().getParameters().get('id');
        util = new CBURLUtil();
    }
    public PageReference redirectToError(String err)
    {
           PageReference pageRef = new PageReference('/apex/error');
           pageRef.getParameters().put('err',err);
           pageRef.setRedirect(true);
           return pageRef; 
    }   
    
    public PageReference route()
    {
        String action = ApexPages.currentPage().getParameters().get('action');
        if(action.equals('update_payment_method')){
            con_id = id;
            //
            String url='';
            if(isUpdate(con_id)){
                url = FlsUtil.getUrlMap().get('update_payment_method');
                url = url +'?id='+con_id;
                url = FlsUtil.safeUrl(url);
                PageReference pageRef = new PageReference('/'+url);
                    
                pageRef.setRedirect(true);
                return pageRef;    
            }else{
                url = '/apex/CBNewCustomer?id='+con_id+'&action=update_payment_method';
                url = FlsUtil.safeUrl(url);
                System.debug('from_page.equals con-----' + url);
                PageReference pageRef = new PageReference('/'+url);
                pageRef.setRedirect(true);
                return pageRef;    
            }
        }
        else if(action.equals('create_subscription'))
        {
            if(from_page.equals('opp'))
            {
                   opp_id=id;
                   List<String> fields1 = new List<String> {'AccountId'};
                    if(!FlsUtil.isPermitable(fields1,'opportunity'))
                    {
                        String fs = FlsUtil.getNotAccessibleFields(fields1,'opportunity','access');
                        redirectToError(fs);
                    }
                    opp_id = String.escapeSingleQuotes(opp_id);
                    String que = 'select AccountId from Opportunity where id=\''+opp_id+'\'';
                    Opportunity opp = Database.query(que); 
                    acc_id = opp.AccountId;
                
            }
            else if(from_page.equals('acc'))
            {
                acc_id = id;
            }
            else if(from_page.equals('con'))
            {
                con_id = id;
                List<String> fields1 = new List<String> {'id','Name','External_Id__c'};
                if(!FlsUtil.isPermitable(fields1,'contact'))
                {
                    String fs = FlsUtil.getNotAccessibleFields(fields1,'contact','access');
                    redirectToError(fs);
                }
                
                    String url='';
                    if(isUpdate(con_id)){
                        //redirect to create subscription
                        url = FlsUtil.getUrlMap().get('create_subscription_con');
                        url = url +'?con_id='+con_id;
                        if(opp_id != null){
                            url=url+'&opp_id='+opp_id;
                        }
                        url = FlsUtil.safeUrl(url);
                        PageReference pageRef = new PageReference('/'+url);
                        //pageRef.getParameters.put('link_url', link);
                        pageRef.setRedirect(true);
                        return pageRef;    
                    }else{
                        url = '/apex/CBNewCustomer?id='+con_id+'&action=create_sub';
                        url = FlsUtil.safeUrl(url);
                        System.debug('from_page.equals con-----' + url);
                        PageReference pageRef = new PageReference('/'+url);
                        //pageRef.getParameters.put('link_url', link);
                        pageRef.setRedirect(true);
                        return pageRef;    
                    }                
            }
            if(con_id == null)
            {
                options3 = new List<SelectOption>();
                List<String> fields1 = new List<String> {'id','Name', 'AccountId'};
                if(!FlsUtil.isPermitable(fields1,'contact'))
                {
                    String fs = FlsUtil.getNotAccessibleFields(fields1,'contact','access');
                    redirectToError(fs);
                }
                acc_id = String.escapeSingleQuotes(acc_id);
                String que = 'select id,Name from Contact where AccountId=\''+acc_id+'\'';
                //List<Contact> cons_list = [ select id,Name from Contact where AccountId=:acc_id];
                List<Contact> cons_list = Database.query(que);
                if(cons_list.size()==1)
                {
                    con_id = cons_list.get(0).id;
                    String url;
                    if(isUpdate(con_id)){
                        //redirect to create subscription
                        url = FlsUtil.getUrlMap().get('create_subscription_con');
                        url = url +'?con_id='+con_id;
                        if(opp_id!=null){
                            url=url+'&opp_id='+opp_id;
                        }
                        url = FlsUtil.safeUrl(url);
                        PageReference pageRef = new PageReference('/'+url);
                        //pageRef.getParameters.put('link_url', link);
                        pageRef.setRedirect(true);
                        return pageRef;
                    }else{
                        url = '/apex/CBNewCustomer?id='+con_id+'&action=create_sub&con_id='+con_id+'&opp_id='+opp_id;
                        url = FlsUtil.safeUrl(url);
                        PageReference pageRef;
                        pageRef = new PageReference('/'+url);
                        pageRef.setRedirect(true);
                        return pageRef;        
                    }
                }
                for(Integer i=0;i<cons_list.size();i++)
                {
                    options3.add(new SelectOption(cons_list.get(i).id+'',cons_list.get(i).Name));
                }
            }
            
        }else if(action.equals('add_charge')){
            String subPk = ApexPages.currentPage().getParameters().get('sub_id');
            String url = '/apex/Add_Charge?sub_id='+EncodingUtil.urlEncode(id,'UTF-8')+'&pk=' + subPk;
            url = FlsUtil.safeUrl(url);
            PageReference pageRef = new PageReference('/'+url);
            return pageRef;
        }else if(action.equals('change_renewal_date')){
            String subPk = ApexPages.currentPage().getParameters().get('sub_id');
            String url = '/apex/ChangeNextRenewalDate?sub_id='+EncodingUtil.urlEncode(id,'UTF-8')+'&pk=' + subPk;
            url = FlsUtil.safeUrl(url);
            PageReference pageRef = new PageReference('/'+url);
            return pageRef;
        }else if(action.equals('cancel_sub')){
            String subPk = ApexPages.currentPage().getParameters().get('sub_id');
            String url = '/apex/Cancel_subscription?sub_id='+id+'&pk=' + subPk;
            url = FlsUtil.safeUrl(url);
            PageReference pageRef = new PageReference('/'+url);
            return pageRef;
        }else if(action.equals('inv_count')){
            CB_Subscription__c sub = [select Id, CB_Id__c, Due_Invoices_Count__c from CB_Subscription__c where Id =: id];
            String endpoint = util.getUrl()+'/api/v2/subscriptions/'+EncodingUtil.urlEncode(sub.CB_Id__c,'UTF-8');
            System.debug('-------'+endpoint);
            String res= CBURLUtil.sendRequest(endpoint,null,util,true,'GET');
            System.debug('-------'+res);
            Map<String, Object> responseMap = CBURLUtil.convertMap(res);
            try{
                Map<String, Object> s = (Map<String, Object>)responseMap.get('subscription');
                Integer count = (Integer)s.get('due_invoices_count');
                System.debug('------'+count);
                sub.Due_Invoices_Count__c=count;
                update sub;
            }
            catch(Exception e)
            {
                System.debug('------'+res);
            }
            PageReference pageRef = new PageReference('/'+id);
            return pageRef;
        }  
        
        return null;
    
    }

    private boolean isUpdate(String con_id){
        List<String> fields1 = new List<String> {'id','Name','External_Id__c'};
        if(!FlsUtil.isPermitable(fields1,'contact'))
        {
            String fs = FlsUtil.getNotAccessibleFields(fields1,'contact','access');
            redirectToError(fs);
            
        }
        con_id = String.escapeSingleQuotes(con_id);
        String que = 'select id,Name,External_Id__c from Contact where id=\''+con_id+'\'';
        Contact cont = Database.query(que); 
        return cont.External_Id__c != null;
    }


}