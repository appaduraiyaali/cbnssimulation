@IsTest(SeeAllData = true) public with sharing class CBCancelSubscriptionTest
{
     @IsTest(SeeAllData = true) public static void testCancel() 
     {
     
     PageReference pageRef = Page.Cancel_subscription;
     test.setCurrentPageReference(pageRef);
     pageRef.getParameters().put('sub_id','a0J2800000JDBbb');
     Test.setMock(HttpCalloutMock.class, new MockRetSubResponseGenerator());
     CBCancelSubscription cbu = new CBCancelSubscription();
     Test.setMock(HttpCalloutMock.class, new MockCancelResponseGenerator());
     cbu.show1();
     cbu.CancelSub();
     }
     @IsTest(SeeAllData = true) public static void testImmediately() 
     {
     
     PageReference pageRef = Page.Cancel_subscription;
     test.setCurrentPageReference(pageRef);
     pageRef.getParameters().put('sub_id','a0J2800000JDBbb');
     Test.setMock(HttpCalloutMock.class, new MockRetSubResponseGenerator());
     CBCancelSubscription cbu1 = new CBCancelSubscription();
     Test.setMock(HttpCalloutMock.class, new MockCancelResponseGenerator());
     cbu1.show1();
     cbu1.save();
     }
     @IsTest(SeeAllData = true) public static void testEot() 
     {
     
     PageReference pageRef = Page.Cancel_subscription;
     test.setCurrentPageReference(pageRef);
     pageRef.getParameters().put('sub_id','a0J2800000JDBbb');
     Test.setMock(HttpCalloutMock.class, new MockRetSubResponseGenerator());
     CBCancelSubscription cbu = new CBCancelSubscription();
     Test.setMock(HttpCalloutMock.class, new MockCancelResponseGenerator());
     cbu.show2();
     cbu.save();
     }
     
     
}