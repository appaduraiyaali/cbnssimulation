@IsTest(SeeAllData = true) public with sharing class CBNewSubscriptionPreviewTest 
{
    @IsTest(SeeAllData = true) public static void testSubscriptionPrev1() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('con_id','0030K00001P2otz');
         pageRef.getParameters().put('opp_id','00628000003jcy8AAA');
         CBNewSubscription cbn = new CBNewSubscription();
         cbn.plans='plannt';
         cbn.invNow=true;
         cbn.stdate=false;
         Test.setMock(HttpCalloutMock.class, new MockEstSubResponseGenerator());
         cbn.preview();
         cbn.selecttab();
         cbn.selecttab1();
         cbn.save();
     }
     @IsTest(SeeAllData = true) public static void testSubscriptionPrev2() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('con_id','0030K00001P2otz');
         pageRef.getParameters().put('opp_id','00628000003jcy8AAA');
         CBNewSubscription cbn = new CBNewSubscription();
         cbn.plans='plannt';
         cbn.sDateStr='2018-06-23 02:30:00';
         cbn.invNow=true;
         cbn.stdate=true;
         Test.setMock(HttpCalloutMock.class, new MockEstSubResponseGenerator());
         cbn.preview();
         cbn.selecttab();
         cbn.selecttab1();
         cbn.save();
     }
     @IsTest(SeeAllData = true) public static void testSubscriptionPrev3() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('con_id','0030K00001P2otz');
         pageRef.getParameters().put('opp_id','00628000003jcy8AAA');
         CBNewSubscription cbn = new CBNewSubscription();
         cbn.plans='plannt';
         cbn.invNow=false;
         cbn.stdate=false;
         Test.setMock(HttpCalloutMock.class, new MockEstSubResponseGenerator());
         cbn.preview();
         cbn.selecttab();
         cbn.selecttab1();
         cbn.save();
     }
     @IsTest(SeeAllData = true) public static void testSubscriptionPrev4() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('con_id','0030K00001P2otz');
         pageRef.getParameters().put('opp_id','00628000003jcy8AAA');
         CBNewSubscription cbn = new CBNewSubscription();
         cbn.plans='plannt';
         cbn.invNow=false;
         cbn.sDateStr='2018-06-23 02:30:00';
         cbn.stdate=true;
         Test.setMock(HttpCalloutMock.class, new MockEstSubResponseGenerator());
         cbn.preview();
         cbn.selecttab();
         cbn.selecttab1();
         cbn.save();
     }
     @IsTest(SeeAllData = true) public static void testSubscriptionPrev5() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('con_id','0030K00001P2otz');
         pageRef.getParameters().put('opp_id','00628000003jcy8AAA');
         CBNewSubscription cbn = new CBNewSubscription();
         cbn.plans='plannt';
         cbn.invNow=false;
         cbn.stdate=false;
         cbn.sDateStr='2018-06-23 02:30:00';
         Test.setMock(HttpCalloutMock.class, new MockCheckoutResponse1Generator());
         cbn.checkout();
         
     }
     @IsTest(SeeAllData = true) public static void testSubscriptionPrev6() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('con_id','0030K00001P2otz');
         
         CBNewSubscription cbn = new CBNewSubscription();
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
         cbn.sameBillAddress = false;
         cbn.plans='plannt';
         cbn.sDateStr='2018-06-23 02:30:00';
         cbn.invNow=false;
         cbn.stdate=true;
         Test.setMock(HttpCalloutMock.class, new MockEstSubResponseGenerator());
         cbn.preview();
         cbn.selecttab();
         cbn.selecttab1();
         cbn.Cancel();
     }
     @IsTest(SeeAllData = true) public static void testSubscriptionPrev7() 
     {
         PageReference pageRef = Page.CBNewSubscription;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('con_id','0030K00001P2otz');
         pageRef.getParameters().put('opp_id','00628000003jcy8AAA');
         CBNewSubscription cbn = new CBNewSubscription();
         cbn.plans='plannt';
         
         Test.setMock(HttpCalloutMock.class, new MockCheckoutResponse1Generator());
         cbn.preview();
         
     }
     
}