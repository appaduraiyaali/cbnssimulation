@IsTest(SeeAllData = true) public with sharing class CBNewSubscriptionTest 
{
     @IsTest(SeeAllData = true) public static void testSubscription() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('opp_id','0062800000Qgyws');
         pageRef.getParameters().put('con_id','00328000003Pcc4');
         CBNewSubscription cbn = new CBNewSubscription();
         cbn.plans='cbdemo_tryme';
         cbn.sFname = 'Test Fname';
         cbn.sLname = 'Test sLname';
         cbn.sEmail = 'hariharan11@chargebee.com';
         cbn.sPhone = '8345678789';
         cbn.sCompany = 'Totodoin';
         cbn.sAddress1 = 'line 1';
         cbn.sAddress2 = 'line 2';
         cbn.sAddress3 = 'line 3';
         cbn.sCity = 'Pleasanton';
         cbn.sState = 'California';
         cbn.sCountry = 'US';                     
         cbn.sZipcode = '98564';
         cbn.save();
     }
     
     @IsTest(SeeAllData = true) public static void testCheckout() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('opp_id','0062800000Qgyws');
         pageRef.getParameters().put('con_id','00328000003Pcc4');
         CBNewSubscription cbn = new CBNewSubscription();
                  cbn.plans='cbdemo_tryme';
         
         cbn.sFname = 'Test Fname';
         cbn.sLname = 'Test sLname';
         cbn.sEmail = 'hariharan11@chargebee.com';
         cbn.sPhone = '8345678789';
         cbn.sCompany = 'Totodoin';
         cbn.sAddress1 = 'line 1';
         cbn.sAddress2 = 'line 2';
         cbn.sAddress3 = 'line 3';
         cbn.sCity = 'Pleasanton';
         cbn.sState = 'California';
         cbn.sCountry = 'US';                     
         cbn.sZipcode = '98564';
         cbn.checkout();
     }
     
    @IsTest(SeeAllData = true) public static void testRedirect() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('opp_id','0062800000Qgyws');
         pageRef.getParameters().put('con_id','00328000003Pcc4');
         CBNewSubscription cbn = new CBNewSubscription();
         cbn.plans='cbdemo_tryme';
         cbn.sFname = 'Test Fname';
         cbn.sLname = 'Test sLname';
         cbn.sEmail = 'hariharan11@chargebee.com';
         cbn.sPhone = '8345678789';
         cbn.sCompany = 'Totodoin';
         cbn.sAddress1 = 'line 1';
         cbn.sAddress2 = 'line 2';
         cbn.sAddress3 = 'line 3';
         cbn.sCity = 'Pleasanton';
         cbn.sState = 'California';
         cbn.sCountry = 'US';                     
         cbn.sZipcode = '98564';
         cbn.page_redirect();
         cbn.cancel_page();
         cbn.saveAccount();
     }     
     
     @IsTest(SeeAllData = true) public static void testSubscriptionWithoutAddress() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('opp_id','0062800000Qgyws');
         pageRef.getParameters().put('con_id','00328000003Pcc4');
         CBNewSubscription cbn = new CBNewSubscription();
         cbn.plans='cbdemo_tryme';
         cbn.sFname = 'Test Fname';
         cbn.sLname = 'Test sLname';
         cbn.sEmail = 'hariharan11@chargebee.com';
         cbn.sPhone = '8345678789';
         cbn.sCompany = 'Totodoin';
         cbn.sameBillAddress = false;
         cbn.save();
     }
}