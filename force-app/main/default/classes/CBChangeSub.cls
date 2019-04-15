public class CBChangeSub
{
    public List<SelectOption> planOpts{get;set;}
    public String oldPlan{get;set;}
    public CBChangeSub(){
        planOpts = new List<SelectOption>();
        planOpts.add(new SelectOption('-1','Select'));
        planOpts.add(new SelectOption('pc','PC'));
        planOpts.add(new SelectOption('lp','Laptop'));
        planOpts.add(new SelectOption('ps','PlayStation'));
        oldPlan='ps';
    
    }
    
}