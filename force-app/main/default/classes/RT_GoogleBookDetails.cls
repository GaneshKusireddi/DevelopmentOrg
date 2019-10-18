public class RT_GoogleBookDetails {
    @Auraenabled
    Public static String getBookDetails(String SearchKey){
        System.debug('SearchKey----->'+SearchKey);
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept','application/json');
        req.setEndpoint('https://www.googleapis.com/books/v1/volumes?q='+searchkey);
        Http http = new Http();
        HTTPResponse res = null;
        res = http.send(req);
        String response = res.getBody();
        System.debug('response----->'+response);
        return response;
    }
}