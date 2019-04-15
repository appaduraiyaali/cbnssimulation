public with sharing class FlsUtil{
        
        public static Map<String,String> getUrlMap(){
                Map<String,String> urlMap = new Map<String,String>();
                urlMap.put('update_payment_method','/apex/UpdatePaymentMethod');
                urlMap.put('create_subscription_con','/apex/New_subscription');
                urlMap.put('add_charge','/apex/Add_Charge');
                urlMap.put('change_renewal_date','/apex/ChangeNextRenewalDate');
                urlMap.put('cancel_sub','/apex/Cancel_subscription');
                urlMap.put('create_cust','/');
            return urlMap;
        }
        
        public void getContact(){
            List<String> fields = new List<String> {'LastName', 'FirstName','Email', 'AccountId', 'Phone', 'MailingStreet', 'MailingCity', 'MailingState', 'MailingCountry', 'MailingPostalCode', 'Auto_collection__c', 'External_Id__c'};
            
          System.debug('-->' + isUpsert(fields,'contact'));
        
        }
        public static String getNotAccessibleFields(List<String> AccessFields,String obj,String action)
        {
            List<String> fs = new List<String>();
            switch on action
            {
                when 'access'
                {
                    for (String fieldToCheck : AccessFields) {
                    if (!getPermissionMap(obj).get(fieldToCheck).getDescribe().isAccessible()) {
                            fs.add(fieldToCheck);
                     }
                 }
                }
                
                when 'update'
                {
                    for (String fieldToCheck : AccessFields) {
                    if (!getPermissionMap(obj).get(fieldToCheck).getDescribe().isUpdateable()) {
                            fs.add(fieldToCheck);
                     }
                 }
                
                }
                
            } 
            return String.join(fs,',');  
        }
        public static boolean isPermitable(List<String> AccessFields,String obj)
        {
            if(objectPermission('access',obj) && objectPermission('query',obj))
            {
                for (String fieldToCheck : AccessFields) {
                    if (!getPermissionMap(obj).get(fieldToCheck).getDescribe().isAccessible()) {
                            return false;
                     }
                 }
                 return true;
             }
             return false;
        }
        public static Map<String,Schema.SObjectField> getPermissionMap(String objType){
        Map<String,Schema.SObjectField> m = null; 
            switch on objType{
                when 'contact' {
                    m = Schema.SObjectType.Contact.fields.getMap();
                }
                when 'account'{
                    m = Schema.SObjectType.Account.fields.getMap();
                }
                when 'pricebookentry'{
                    m = Schema.SObjectType.PricebookEntry.fields.getMap();
                }
                when 'product2'{
                    m = Schema.SObjectType.Product2.fields.getMap();
                }
                when 'opportunity'{
                    m = Schema.SObjectType.Opportunity.fields.getMap();
                }
                when 'CB_Subscription__c'{
                    m = Schema.SObjectType.CB_Subscription__c.fields.getMap();
                }
                when 'Coupon__c'{
                    m = Schema.SObjectType.Coupon__c.fields.getMap();
                }
                when 'Chargebee_Config__c'{
                    m = Schema.SObjectType.Chargebee_Config__c.fields.getMap();
                    
                }
                when 'Pricebook2'{
                    m = Schema.SObjectType.Pricebook2.fields.getMap();
                    
                }
            
            }
            return m;
        }
        public static boolean isUpdate(List<String> AccessFields,String obj)
        {
            Map<String,Schema.SObjectField> m = getPermissionMap(obj); 
            if(objectPermission('update',obj))
            {
                Schema.SObjectType.Contact.fields.getMap();
                for (String fieldToCheck : AccessFields) {
                    if (!m.get(fieldToCheck).getDescribe().isUpdateable()) {
                            return false;
                     }
                 }
                 return true;
            }
            return false;     
        }
        
        public static boolean objectPermission(String action,String objType)
        {
            boolean b;
            switch on action
            {
                when 'access'
                {
                        switch on objType{
                            when 'contact' {
                                b= Schema.SObjectType.Contact.isAccessible();
                            }
                            when 'account'{
                                b= Schema.SObjectType.Account.isAccessible();
                            }
                            when 'pricebookentry'{
                                b= Schema.SObjectType.PricebookEntry.isAccessible();
                            }
                            when 'product2'{
                                b= Schema.SObjectType.Product2.isAccessible();
                            }
                            when 'opportunity'{
                                b= Schema.SObjectType.Opportunity.isAccessible();
                            }
                            when 'CB_Subscription__c'{
                                b= Schema.SObjectType.CB_Subscription__c.isAccessible();
                            }
                            when 'Coupon__c'{
                                b= Schema.SObjectType.Coupon__c.isAccessible();
                            }
                            when 'Chargebee_Config__c'{
                                b= Schema.SObjectType.Chargebee_Config__c.isAccessible();
                            }
                            when 'Pricebook2'{
                                b= Schema.SObjectType.Pricebook2.isAccessible();
                            }
                    
                    }
                }
                
                when 'update'
                {
                        switch on objType{
                            when 'contact' {
                                b= Schema.SObjectType.Contact.isUpdateable();
                            }
                            when 'account'{
                                b= Schema.SObjectType.Account.isUpdateable();
                            }
                            when 'pricebookentry'{
                                b= Schema.SObjectType.PricebookEntry.isUpdateable();
                            }
                            when 'product2'{
                                b= Schema.SObjectType.Product2.isUpdateable();
                            }
                            when 'opportunity'{
                                b= Schema.SObjectType.Opportunity.isUpdateable();
                            }
                            when 'CB_Subscription__c'{
                                b= Schema.SObjectType.CB_Subscription__c.isUpdateable();
                            }
                            when 'Coupon__c'{
                                b= Schema.SObjectType.Coupon__c.isUpdateable();
                            }
                            when 'Chargebee_Config__c'{
                                b= Schema.SObjectType.Chargebee_Config__c.isUpdateable();
                            }
                            when 'Pricebook2'{
                                b= Schema.SObjectType.Pricebook2.isUpdateable();
                            }
                    
                    }
                }
                
                when 'create'
                {
                        switch on objType{
                            when 'contact' {
                                b= Schema.SObjectType.Contact.isCreateable();
                            }
                            when 'account'{
                                b= Schema.SObjectType.Account.isCreateable();
                            }
                            when 'pricebookentry'{
                                b= Schema.SObjectType.PricebookEntry.isCreateable();
                            }
                            when 'product2'{
                                b= Schema.SObjectType.Product2.isCreateable();
                            }
                            when 'opportunity'{
                                b= Schema.SObjectType.Opportunity.isCreateable();
                            }
                            when 'CB_Subscription__c'{
                                b= Schema.SObjectType.CB_Subscription__c.isCreateable();
                            }
                            when 'Coupon__c'{
                                b= Schema.SObjectType.Coupon__c.isCreateable();
                            }
                            when 'Chargebee_Config__c'{
                                b= Schema.SObjectType.Chargebee_Config__c.isCreateable();
                            }
                            when 'Pricebook2'{
                                b= Schema.SObjectType.Pricebook2.isCreateable();
                            }
                    
                    }
                }
                
                when 'query'
                {
                        switch on objType{
                            when 'contact' {
                                b= Schema.SObjectType.Contact.isQueryable();
                            }
                            when 'account'{
                                b= Schema.SObjectType.Account.isQueryable();
                            }
                            when 'pricebookentry'{
                                b= Schema.SObjectType.PricebookEntry.isQueryable();
                            }
                            when 'product2'{
                                b= Schema.SObjectType.Product2.isQueryable();
                            }
                            when 'opportunity'{
                                b= Schema.SObjectType.Opportunity.isQueryable();
                            }
                            when 'CB_Subscription__c'{
                                b= Schema.SObjectType.CB_Subscription__c.isQueryable();
                            }
                            when 'Coupon__c'{
                                b= Schema.SObjectType.Coupon__c.isQueryable();
                            }
                            when 'Chargebee_Config__c'{
                                b= Schema.SObjectType.Chargebee_Config__c.isQueryable();
                            }
                            when 'Pricebook2'{
                                b= Schema.SObjectType.Pricebook2.isQueryable();
                            }
                    
                    }
                }
                
            }
            return b;
            
        }
        public static boolean isUpsert(List<String> AccessFields,String obj)
        {
            
            Map<String,Schema.SObjectField> m = getPermissionMap(obj); 
            //boolean b = Schema.SObjectType.Contact.isAccessible();
            if(objectPermission('create',obj) && objectPermission('update',obj))
            {
                Schema.SObjectType.Contact.fields.getMap();
                for (String fieldToCheck : AccessFields) {
                    System.debug('-->>' + fieldToCheck);
                    if (!(m.get(fieldToCheck).getDescribe().isUpdateable() && m.get(fieldToCheck).getDescribe().isCreateable())) {
                            System.debug('- false');
                            return false;
                     }
                 }
                 return true;
             }
             return false;
        }
        public static String safeUrl(String unsafe_url)
        {
            //String ww='';
            if(unsafe_url.startsWith('/')){
                unsafe_url=unsafe_url.replaceFirst('/+','');
            }
            
            return unsafe_url;
 
        }
}