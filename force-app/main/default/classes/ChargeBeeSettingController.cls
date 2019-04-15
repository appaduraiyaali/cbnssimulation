public with sharing class ChargeBeeSettingController {

 public CustomSettingProxy setting{get; set;}
 public String overRideAllowed{get;set;}
 public String autoCollection{get;set;} 
 public List<SelectOption> autoCollOptions{get;set;}
 public String hostedPageVersion{get;set;} 
 public List<SelectOption> hostedPages{get;set;}
 
 
 
    public ChargeBeeSettingController() {
     
     //chargebee_settings__c mhc = chargebee_settings__c.getInstance();
     setting = new CustomSettingProxy();
     overRideAllowed = isOverRideAllowed();
     autoCollection = autoCollection();
     autoCollOptions = new List<SelectOption>();
     autoCollOptions.add(new SelectOption('OFF','OFF'));
     autoCollOptions.add(new SelectOption('ON','ON'));
     hostedPageVersion = getHostedPageVersion();
     hostedPages = new List<SelectOption>();
     hostedPages.add(new SelectOption('V3','V3 Hostedpage'));
     hostedPages.add(new SelectOption('V2','V2 HostedPage'));
     
    }

public String getHostedPageVersion(){
     String temp = setting.siteSetting;
     if(temp != null){
         Map<String, String> b = (Map<String,String>) JSON.deserialize(temp, Map<String,String>.class);
         System.debug(b);
         if(b.get('useV3UpdatePayment') != null && b.get('useV3UpdatePayment').equals('V3')){
             hostedPageVersion = 'V3';
         }
         else{
             hostedPageVersion = 'V2';
         }
     }
     return hostedPageVersion;
 }
     
public String isOverRideAllowed(){
     String temp = setting.siteSetting;
     if(temp != null){
         Map<String, String> b = (Map<String,String>) JSON.deserialize(temp, Map<String,String>.class);
         System.debug(b);
         if(b.get('isOverRide') != null && b.get('isOverRide').equals('true')){
             overRideAllowed = 'Enabled';
         }
         else{
             overRideAllowed = 'Disabled';
         }
     }
     return overRideAllowed;
 }
 
 public String autoCollection(){
     String temp = setting.siteSetting;
     if(temp != null){
         Map<String, String> b = (Map<String,String>) JSON.deserialize(temp, Map<String,String>.class);
         System.debug(b);
         if(b.get('autoCollectionFlag') != null){
             autoCollection = b.get('autoCollectionFlag');
         }
         else{
             autoCollection = 'ON';
         }
     }
     return autoCollection;
 }
    
    

public class CustomSettingProxy {
        public String apikey {get;set;}
        public String chargebeeurl {get;set;}
        public String username {get;set;}
        public String siteSetting {get;set;}
        chargebee__c mhc{get;set;}
        
        public CustomSettingProxy() {
            try{
            /*
                List<String> fields1 = new List<String> {'API_Key__c', 'ChargeBee_URL__c','Settings_JSON__c','User_Name__c'};
                if(!FlsUtil.isPermitable(fields1,'Chargebee_Config__c'))
                {
                    redirectToError();
                }
                */
                //mhc = [select API_Key__c, ChargeBee_URL__c,Settings_JSON__c,User_Name__c from chargebee_settings__c ];
                mhc = chargebee__c.getOrgDefaults();
            }catch(Exception e){
                System.debug('-err---' + e);
            }
            System.debug('--->>' + mhc);
            this.apikey= mhc != null?mhc.API_Key__c:'';
            this.username = mhc != null?mhc.User_Name__c:'';
            this.chargebeeurl = mhc != null?mhc.ChargeBee_URL__c:'';
            this.siteSetting = mhc != null?mhc.Settings_JSON__c:null;
            
        }
        public PageReference redirectToError()
        {
           PageReference pageRef = new PageReference('/apex/error');
           pageRef.setRedirect(true);
           return pageRef; 
        }


        
         /*public void insertSetting() {
            try{    
                if(mhc != null){
                     mhc.API_Key__c=apikey;
                     mhc.User_Name__c=username;
                     mhc.ChargeBee_URL__c=chargebeeurl;
                     mhc.CB_Primary__c = 1;
                     mhc.Settings_JSON__c = siteSetting;
                     List<String> fields1 = new List<String> {'Subscription_Plan__c'};
                     if(!FlsUtil.isUpdate(fields1,'Chargebee_Config__c'))
                     {
                         redirectToError();
                     }
                     update mhc;
                }
                }catch(exception e)
                {
                    System.debug('err--->>' + e);
                }
        }*/

    }

   
   }