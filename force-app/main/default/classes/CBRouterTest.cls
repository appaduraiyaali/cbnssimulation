@IsTest(SeeAllData = true) public with sharing class CBRouterTest 
{
     @IsTest(SeeAllData = true) public static void testCBRouterOpp() 
     {
     
         PageReference pageRef = Page.CBRouter;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('id','0062800000KCSAn');
         pageRef.getParameters().put('action','create_subscription');
         pageRef.getParameters().put('from','opp');
         
         //String url='/apex/CBRouter?action=create_subscription&opp_id=0062800000KCSNI&from=opp';
         //PageReference pageRef = new PageReference(url);
          //pageRef.getParameters.put('link_url', link);
          //Test.setCurrentPageReference(pageRef);
          CBRouter cbr = new CBRouter();
          cbr.route();
     }
     
     @IsTest(SeeAllData = true)public static void testCBRouterCon() 
     {
         //String url='/apex/CBRouter?action=create_subscription&opp_id=0062800000KCSNI&from=opp';
         //PageReference pageRef = new PageReference(url);
          //pageRef.getParameters.put('link_url', link);
          //Test.setCurrentPageReference(pageRef);
         PageReference pageRef = Page.CBRouter;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('id','00328000012BTsO');
         pageRef.getParameters().put('action','create_subscription');
         pageRef.getParameters().put('from','con');          
          CBRouter cbr = new CBRouter();//'create_subscription','con','00328000012BTsO');
          cbr.route();
     }   
     
     @IsTest(SeeAllData = true)public static void testCBRouterupdate() 
     {
         //String url='/apex/CBRouter?action=create_subscription&opp_id=0062800000KCSNI&from=opp';
         //PageReference pageRef = new PageReference(url);
          //pageRef.getParameters.put('link_url', link);
          //Test.setCurrentPageReference(pageRef);
        PageReference pageRef = Page.CBRouter;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('id','00328000012BTsO');
         pageRef.getParameters().put('action','update_payment_method');
         pageRef.getParameters().put('from','con');           
          CBRouter cbr = new CBRouter();//'update_payment_method','con','00328000012BTsO');
          cbr.route();
     }        
     
    
     
     @IsTest(SeeAllData = true)public static void testCBRouterSub() 
     {
         //String url='/apex/CBRouter?action=create_subscription&opp_id=0062800000KCSNI&from=opp';
         //PageReference pageRef = new PageReference(url);
          //pageRef.getParameters.put('link_url', link);
          //Test.setCurrentPageReference(pageRef);
         PageReference pageRef = Page.CBRouter;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('id','00328000012BTsO');
         pageRef.getParameters().put('action','create_subscription');
         pageRef.getParameters().put('from','con');           
          CBRouter cbr = new CBRouter();
          cbr.con_id = '0030K00001bn1ot';
          cbr.createSubscription();
     } 
     
     
          
     
     @IsTest(SeeAllData = true) public static void testCBRouterAcc() 
     {
         //String url='/apex/CBRouter?action=create_subscription&opp_id=0062800000KCSNI&from=opp';
         //PageReference pageRef = new PageReference(url);
          //pageRef.getParameters.put('link_url', link);
          //Test.setCurrentPageReference(pageRef);
         PageReference pageRef = Page.CBRouter;    
                  test.setCurrentPageReference(pageRef);
      
         pageRef.getParameters().put('id','00128000015tfJd');
         pageRef.getParameters().put('action','create_subscription');
         pageRef.getParameters().put('from','acc');           
          CBRouter cbr = new CBRouter();//'create_subscription','acc','00128000015tfJd');
          cbr.route();
     }     
}