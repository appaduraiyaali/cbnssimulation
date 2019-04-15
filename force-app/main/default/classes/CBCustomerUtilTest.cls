@IsTest(SeeAllData = true) public with sharing class CBCustomerUtilTest 
{
     @IsTest(SeeAllData = true) public static void testCBCreate() 
     {
     
     
     PageReference pageRef = Page.CBNewCustomerUtil;
     test.setCurrentPageReference(pageRef);
     pageRef.getParameters().put('id','00328000012BTsO');
     pageRef.getParameters().put('url','/003/o');
     CBNewCustomerUtil cbu = new CBNewCustomerUtil();
     Test.setMock(HttpCalloutMock.class, new MockCustGenerator());
     cbu.createCustomer('00328000012BTsO');
     
     
         /*String id = '00328000012BTsO';
         Account acct  = null;
         Contact cont = [select LastName, FirstName,Email, AccountId, MobilePhone, MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Auto_collection__c, External_Id__c from contact where id=:id];   
         if(cont.AccountId != null)
            {
               acct = [select Name from Account where id=:cont.AccountId];
            }   
         CBNewCustomerUtil cbu = new CBNewCustomerUtil('00328000012BTsO',cont,acct);
         cbu.cus_id = '00328000012BTsO';
         cbu.createCustomer();
         0032800000xXAYx
         */
     }
     
     @IsTest(SeeAllData = true) public static void testCBCreatenew() 
     {
     
     Contact cont = [select LastName, FirstName,Email, AccountId, MobilePhone, MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Auto_collection__c, External_Id__c from contact where id=:'0032800000xXAYx'];    
     cont.External_Id__c = null;
     cont.MobilePhone ='9003653138';
     update cont;
     
     PageReference pageRef = Page.CBNewCustomerUtil;
     test.setCurrentPageReference(pageRef);
     pageRef.getParameters().put('id','0032800000xXAYx');
     pageRef.getParameters().put('url','/003/o');
     CBNewCustomerUtil cbu = new CBNewCustomerUtil();
     cbu.createCustomer('0032800000xXAYx');
     cbu.back();
     
     }     
     
     @IsTest(SeeAllData = true) public static void testCBCreateNoEmail() 
     {
     
     Contact cont = [select LastName, FirstName,Email, AccountId, Phone, MobilePhone, MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Auto_collection__c, External_Id__c from contact where id=:'0032800000mXV4F'];    
     cont.External_Id__c = null;
     cont.MobilePhone ='9003653138';
     update cont;
     
     PageReference pageRef = Page.CBNewCustomerUtil;
     test.setCurrentPageReference(pageRef);
     pageRef.getParameters().put('id','0032800000mXV4F');
     pageRef.getParameters().put('url','/003/o');
     CBNewCustomerUtil cbu = new CBNewCustomerUtil();
     cbu.createCustomer('0032800000mXV4F');
     cbu.back();
     
     }    
     
     @IsTest(SeeAllData = true) public static void testCBCreateWithExternalId() 
     {
     
     //Contact cont = [select LastName, FirstName,Email, AccountId, Phone, MobilePhone, MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Auto_collection__c, External_Id__c from contact where id=:'00328000012BSee'];    
     //cont.MobilePhone ='9003653138';
     //update cont;
     
     PageReference pageRef = Page.CBNewCustomerUtil;
     test.setCurrentPageReference(pageRef);
     pageRef.getParameters().put('id','00328000012BSee');
     pageRef.getParameters().put('url','/003/o');
     CBNewCustomerUtil cbu = new CBNewCustomerUtil();
     Test.setMock(HttpCalloutMock.class, new MockCustGenerator());
     cbu.createCustomer('00328000012BSee');
     cbu.back();
     
     } 
 }