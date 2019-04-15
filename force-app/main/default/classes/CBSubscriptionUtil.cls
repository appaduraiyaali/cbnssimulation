public class CBSubscriptionUtil{

    public static String getEstimateEndPoint(CBURLUtil urlUtil, String contExtId){
        return urlUtil.getUrl()+'/api/v2/customers/'+contExtId+'/create_subscription_estimate?';
    }
    
    public static String getAddonURL(List<AddonObject> selList,String bodyData, Map<String,String> PlanExternalIdVsChargeModel, boolean canOverRide){
        
        for(Integer i=0,j=0;i<selList.size();i++)
        {
            AddonObject temp_add_obj = selList.get(i);
            System.debug('temp_add_obj addons--' + temp_add_obj);        
            if((temp_add_obj.status == 2 || temp_add_obj.status == 3) && !temp_add_obj.addon.equals('-1'))
            {
                bodyData = CBURLUtil.buildURLString(bodyData,'addons[id]['+j+']',temp_add_obj.addon);
                
                
                if(PlanExternalIdVsChargeModel != null && PlanExternalIdVsChargeModel.get(temp_add_obj.addon + '_CHARGE_MODEL') != null && PlanExternalIdVsChargeModel.get(temp_add_obj.addon + '_CHARGE_MODEL') == 'QUANTITY' && temp_add_obj.qty>0){
                    bodyData = CBURLUtil.buildURLString(bodyData,'addons[quantity]['+j+']',String.valueOf(temp_add_obj.qty));
                }
                else{
                    bodyData = CBURLUtil.buildURLString(bodyData,'addons[quantity]['+j+']',String.valueOf(temp_add_obj.qty));
                }
                if(canOverRide && temp_add_obj.price != null){
                    bodyData = CBURLUtil.buildURLString(bodyData,'addons[unit_price]['+j+']',String.valueOf(ChargebeeUtil.convertToLowerOrderCurrency(temp_add_obj.addonCurrency, Double.valueOf(String.valueOf(temp_add_obj.price)))));
                }
                j++;
            }
        }
      return bodyData;
    }
    
    
    public static String getCreateSubscriptionEndPoint(CBURLUtil urlUtil, String contExtId){
        return urlUtil.getUrl()+'/api/v2/customers/'+contExtId+'/subscriptions';
    }
    
    public static String getListUnbilledChargesEndPoint(CBURLUtil urlUtil){
        return urlUtil.getUrl()+'/api/v2/unbilled_charges';
    }
    
    public static String getUnbilledChargesEstimateEndPoint(CBURLUtil urlUtil){
        return urlUtil.getUrl()+'/api/v2/unbilled_charges/invoice_now_estimate';
    }
    
    public static String getInvoiceUnbilledChargesEndPoint(CBURLUtil urlUtil){
        return urlUtil.getUrl()+'/api/v2/unbilled_charges/invoice_unbilled_charges';
    }
    
    public static String getCancelSubscriptionEndPoint(CBURLUtil urlUtil, String sub_id){
        return urlUtil.getUrl()+'/api/v2/subscriptions/'+EncodingUtil.urlEncode(sub_id,'UTF-8')+'/cancel';
    }
    
    public static String getUpdateTPEndPoint(CBURLUtil urlUtil){
        return urlUtil.getUrl()+'/api/v2/third_party_entity_mappings/update_entity';
    }
    
    public static String getSyncSubsEndPoint(CBURLUtil urlUtil){
        return urlUtil.getUrl()+'/salesfoce/api/sync_subscription';
    }
    
    public static String getImmediateChargeDisplayText(String curCode,Datetime sDate, Double tot){
        return 'There will be no immediate charges.An invoice for '+curCode+' '+tot+' will be generated upon activation on '+sDate;
    }
    
    public static String getInvDisplayText(String curCode,Double tot){
        return 'An invoice for '+curCode+' '+tot+' will be generated immediately.';
    }
    
    public static String getNoChargeDisplayText(){
        return 'There are no charges.';
    }
    
    public static String getNoChargeWithTotDisplayText(String curCode,Double tot){
        return 'There are no charges. An amount of '+curCode+' '+tot+' will be added to the upcoming invoice.';
    }
    
    public static DateTime getSubscriptionStartDate(String sDateStr){
        DateTime sDate;
        if(sDateStr!=null){
            sDateStr += ':00';
        }
        try{
        sDate = DateTime.newInstance(Integer.valueOf(sDateStr.subString(0,4)),
                    Integer.valueOf(sDateStr.subString(5,7)),Integer.valueOf(sDateStr.subString(8,10)),
                    Integer.valueOf(sDateStr.subString(11,13)),Integer.valueOf(sDateStr.subString(14,16)),
                    Integer.valueOf(sDateStr.subString(17,19)));
        
        }catch(exception e){
            sDate = system.now();
        }
        return sDate;
    }
    
    public static String getDataForTpSync(String opp_id, String bodyData){
        bodyData = CBURLUtil.buildURLString(bodyData,'entity_type','subscription');
        bodyData = CBURLUtil.buildURLString(bodyData,'integration_name','salesforce');
        bodyData = CBURLUtil.buildURLString(bodyData,'status','CREATE_FAILED');
        bodyData = CBURLUtil.buildURLString(bodyData,'error_message','sync not started its done by SF');
        if(opp_id!=null && opp_id!='-1'){
            bodyData = CBURLUtil.buildURLString(bodyData,'mapping_meta','{"opp_id":"'+opp_id+'"}');
        }                
        return bodyData;
    }
    
    public static String getCheckoutURL(CBURLUtil urlUtil){
        return urlUtil.getUrl()+'/api/v2/hosted_pages/checkout_new';
    }
    
    public static List<SelectOption> sortSelectOptions(List<SelectOption> sortingList) {
    for (Integer i =0; i < sortingList.size(); i++) {
        for (Integer j = i; j > 0; j--) {
            if (sortingList[j-1].getLabel() > sortingList[j].getLabel() && sortingList[j].getLabel() != 'Select' && sortingList[j-1].getLabel() != 'Select'){
                SelectOption temp = sortingList[j];
                sortingList[j] = sortingList[j-1];
                sortingList[j-1] = temp;
            }
        }
    }
    System.debug('after sort--' + sortingList);
    return sortingList;
    }


}