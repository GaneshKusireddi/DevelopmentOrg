public class RT_GetAccountUsingRESTAPI {
    private final String clientId = '3MVG9G9pzCUSkzZv.KmqVRThwJoUNLX8tMZPnhDEXPFDbY6MEfzoAOEiaYQZX3JvCKKwND9pPHDjKPrgLA8fY';
    private final String clientSecret = '56D07CFA35C9F0DBE6E8A74FDDC2601140291A2D6C94A00B6B7A08799D9B16A8';
    private final String username = 'ganesh111@raagvitech.com';
    private final String password = 'ganesh@123UNoAgwXcOdh0XbEUDRoltQuw';
    
    public class deserializeResponse
    {
        public String id;
        public String access_token;
    }
    
    public String ReturnAccessToken (RT_GetAccountUsingRESTAPI acount)
    {
        String reqbody = 'grant_type=password' + '&client_id='+clientId +
            '&client_secret='+clientSecret + '&username='+username + '&password='+password;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HttpResponse res = h.send(req);
        System.debug('Status ' + res.getStatus());
        deserializeResponse response = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
        system.debug('@@@@access_token@@'+response );
        return response.access_token;
    }
    
    public static list<account> callGetAccount()
    {
        RT_GetAccountUsingRESTAPI acount1 = new RT_GetAccountUsingRESTAPI();
        String accessToken;
        accessToken = acount1.ReturnAccessToken (acount1);
        list<account> ListAccount=new List<account>();
        if(accessToken != null){
            String endPoint = 'https://ganesh000-dev-ed.my.salesforce.com/services/apexrest/v1/getAccounts/';
            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setMethod('GET');
            req1.setEndpoint(endPoint);
            HttpResponse res1 = h2.send(req1);
            String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
            system.debug('@@@RESPONSE@@'+trimmedResponse);
            JSONParser parser = JSON.createParser(res1.getBody());
            set<account> accList=new set<account>();
            while (parser.nextToken() != null) {
                if((parser.getCurrentToken() == JSONToken.FIELD_NAME) ){
                    Account acc;
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Id')) {
                        parser.nextToken();
                        String sId= parser.getText();
                        acc=new Account();
                        acc.Id=sId;
                        system.debug('Id@@@'+ sId);
                        parser.nextToken();
                        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Name')) {
                            parser.nextToken();
                            string sName= parser.getText();
                            acc.Name=sName;
                            system.debug('Name@@@' + sName );
                        }
                    }
                    accList.add(acc);
                }
                accList.remove(null);
            }
            ListAccount.AddAll(accList);
            system.debug('AccountList@@@@--->'+Json.serialize(ListAccount));
            /*    String str = JSON.serialize(ListAccount);
list<account> ListAccounts =  (list<account>)JSON.deserialize(str, list<account>.class);
system.debug('ListAccounts-<><>-->'+ListAccounts);
Insert ListAccounts;*/
        }
        //---------To insert records in target org--------      
        List<account> accList = new List<account>();
        for(Account acc:ListAccount){
            accList.add(new Account(Name =acc.Name));
        }
        system.debug('accListtobeInsert--->'+accList);
        Insert accList;
        
        return ListAccount;
    }
}