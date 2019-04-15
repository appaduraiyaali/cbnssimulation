@IsTest public with sharing class CBUrlTest 
{
     @IsTest(SeeAllData=true) public static void testCBUrl() 
     {
         CBURLUtil urlUtil = new CBURLUtil();
         String url = urlUtil.getUrl();
         String api_key = urlUtil.getApiKey();
         System.assertNotEquals(url,null);
         System.assertNotEquals(api_key,null); 
         System.assertEquals(url,'https://cbtest1.chargebee.com');
         
     }
     
     @IsTest(SeeAllData=true) public static void testCBUrl1() 
     {
         CBURLUtil urlUtil = new CBURLUtil();
         String url = urlUtil.getUrl();
         String api_key = urlUtil.getApiKey();
         Test.setMock(HttpCalloutMock.class, new MockCustGenerator());
         String resp = CBURLUtil.sendRequest('https://cbtest1.chargebee.com/api/v2/subscriptions/1mkVvwZQYZrOPS3c40/change_term_end_estimate','',urlUtil,true);
         System.assertNotEquals(url,null);
         System.assertNotEquals(api_key,null); 
         System.assertEquals(url,'https://cbtest1.chargebee.com');
         
     }
}