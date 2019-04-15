public class GenError
{
    public String err{get;set;}
    public String objNames{get;set;}
    
    public GenError()
    {
        err = ApexPages.currentPage().getParameters().get('err');
        objNames = ApexPages.currentPage().getParameters().get('obj');
        
    }
}