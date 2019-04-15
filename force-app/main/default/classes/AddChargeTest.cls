@IsTest
public class AddChargeTest 
{
     @IsTest(SeeAllData = true)
     public static void test1() 
     {
         PageReference pageRef = Page.Add_Charge;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('sub_id','1mk51ePQSZ5k7VILl');
         pageRef.getParameters().put('pk','0032800001KlI0J');
         AddCharge ch = new AddCharge();
         ch.invoiceOpt = 'ADD_UNBILLED_CHARGE';
         ch.amount = '1000';
         ch.description = 'test';
         ch.save();
     
     }
     
    @IsTest(SeeAllData = true)
     public static void test2() 
     {
         PageReference pageRef = Page.Add_Charge;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('sub_id','1mk51ePQSZ5k7VILl');
         pageRef.getParameters().put('pk','0032800001KlI0J');
         AddCharge ch = new AddCharge();
         ch.invoiceOpt = 'INVOICE_NOW';
         ch.amount = '1000';
         ch.description = 'test';
         ch.save();
     
     }     
 }