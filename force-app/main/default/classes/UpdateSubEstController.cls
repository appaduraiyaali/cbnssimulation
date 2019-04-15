public class UpdateSubEstController extends BaseEstimateController{
    
    public override void createURL(Map<String,String> params){
    
    
        UpdateSubUrlBuilder usub = new UpdateSubUrlBuilder();
        if(params.get('plan_id')!=null){
            usub.planId(params.get('plan_id'));
        }
        if(params.get('plan_quantity')!=null){
            usub.planQuan(params.get('plan_quantity'));
        }
        if(params.get('plan_unit_price')!=null){
            usub.planUnitPrice(params.get('plan_unit_price'));
        }
        if(params.get('setup_fee')!=null){
            usub.planSetupFee(params.get('setup_fee'));
        }
        if(params.get('start_date')!=null){
            usub.startDate(params.get('start_date'));
        }
        if(params.get('trial_end')!=null){
            usub.trialEnd(params.get('trial_end'));
        }
        if(params.get('billing_cycles')!=null){
            usub.billingCycles(params.get('billing_cycles'));
        }
        if(params.get('po_number')!=null){
            usub.poNum(params.get('po_number'));
        }
        if(params.get('coupon_ids[0]')!=null){
            usub.couponId(params.get('coupon_ids[0]'));
        }
        if(params.get('prorate')!=null){
            usub.prorate(params.get('prorate'));
        }
        if(params.get('end_of_term')!=null){
            usub.endOfTerm(params.get('end_of_term'));
        }
        if(params.get('invoice_immediately')!=null){
            usub.invoiceImmediately(params.get('invoice_immediately'));
        }
        if(params.get('reactivate')!=null){
            usub.reactivate(params.get('reactivate'));
        }
        if(params.get('replace_addon_list')!=null){
            usub.replaceAddons(params.get('replace_addon_list'));
        }
        
        setBuilder(usub);
        
    }
    
    
    public UpdateSubEstController(UpdateSubUrlBuilder ub){
            super(ub);
    }
    
    public UpdateSubEstController(){
        super();
    }

}