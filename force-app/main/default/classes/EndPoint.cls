public class EndPoint{
    public String url{get;set;}
    public RequestType reqtype{get;set;}
    
    public EndPoint(String ul,RequestType rt){
        url=ul;
        reqtype=rt;
    }

}