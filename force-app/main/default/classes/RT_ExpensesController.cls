public with sharing class RT_ExpensesController {
    @AuraEnabled
    public static void createExpenses(Expense__c newExpenses, String recID) {
        system.debug('>>inside createExpenses>>>>');
        newExpenses.Client__c =recID;
        system.debug('>>>>>>'+recID);
        Insert newExpenses;
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