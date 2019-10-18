public class RT_AccountQuickActionController {
 @AuraEnabled
    public static void createAccount(Account objAccount, String recID) {
        system.debug('>>inside createAccount>>>>');
        system.debug('>>objAccount>>>>'+objAccount);
        system.debug('>>>>>>'+recID);
        decimal num = objAccount.NumberOfEmployees;
        objAccount.NumberOfEmployees = objAccount.NumberOfEmployees;
        if(String.isNotBlank(recID)){
            objAccount.ParentId =recID;
        }
        Insert objAccount;
    }
    @AuraEnabled
    public static List <account> fetchAccount(String searchKeyWord) {
        System.debug('>>>>>searchKeyWord>>>'+searchKeyWord);
        String searchKey = searchKeyWord + '%';
        List < Account > lstOfAccount = [select id, Name from account where Name LIKE: searchKey];
        System.debug('>>>>>lstOfAccount>>>'+lstOfAccount);
        return lstOfAccount;
    }
}