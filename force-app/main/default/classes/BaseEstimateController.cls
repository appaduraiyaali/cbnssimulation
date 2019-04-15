public abstract class BaseEstimateController{
    private URLBuilder urlbuild;
    private RequestMaker rm;
    
    public BaseEstimateController(){
        rm=new RequestMaker();
    }
    
    public BaseEstimateController(URLBuilder ub){
         urlbuild=ub;
         rm = new RequestMaker(ub);  
    }
    
    public abstract void createURL(Map<String,String> params);
     
    
    public void setEndpoint(EndPoint ep){
        urlbuild.setEndPoint(ep);
    }
    
    public Map<String,Object> makeRequest(){
        return rm.makeRequest();
    }
    
    public boolean errorResponse(){
        return rm.isError();
    }
    
    public BaseError getErrorObject(){
        return rm.getErrorObject();
    }
    
    public void setBuilder(URLBuilder ub){
        rm.setBuilder(ub);
    }
}