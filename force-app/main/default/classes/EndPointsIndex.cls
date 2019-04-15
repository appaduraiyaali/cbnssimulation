public class EndPointsIndex{

    public static final EndPoint update_est_url= new EndPoint('https://cbtest1.chargebee.com/api/v2/estimates/update_subscription', RequestType.POST);
    public static final EndPoint retrieve_sub_url = new EndPoint('https://cbtest1.chargebee.com/api/v2/subscriptions/',RequestType.GET);
}