@IsTest(SeeAllData = true) public with sharing class CBCustomerTest
{
     @IsTest(SeeAllData = true) public static void testCBCreate() 
     {
     
     PageReference pageRef = Page.CBNewCustomer;
     test.setCurrentPageReference(pageRef);
     pageRef.getParameters().put('id','00328000003Pcc4');
     pageRef.getParameters().put('url','/003/o');
     pageRef.getParameters().put('action','sync');
     CBNewCustomer cbu = new CBNewCustomer();
     Test.setMock(HttpCalloutMock.class, new MockCustGenerator());
     cbu.createCustomer();
     cbu.back();
     }
     
     @IsTest(SeeAllData = true) public static void testCBCreateNew() 
     {
     
     Contact cont = [select LastName, FirstName,Email, AccountId, MobilePhone, MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Auto_collection__c, External_Id__c from contact where id=:'0032800000xXAYx'];    
     cont.External_Id__c = null;
     update cont;
     
     PageReference pageRef = Page.CBNewCustomer;
     test.setCurrentPageReference(pageRef);
     pageRef.getParameters().put('id','0032800000xXAYx');
     pageRef.getParameters().put('url','/003/o');
     pageRef.getParameters().put('action','sync');     
     CBNewCustomer cbu = new CBNewCustomer();
     cbu.createCustomer();
     cbu.back();
     }
}