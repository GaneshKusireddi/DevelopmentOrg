@RestResource(urlMapping='/Expense__c/*')
global with sharing class RT_RestApiCallOnExpense {
    @HttpPost
    global static void doPost(List<String> ExpenseIds) {
        Set<Id> setOfIds =  new Set<Id>();
        for(String str : ExpenseIds){
            setOfIds.add(str);
        }
        List<Expense__c> lstOfExpenseToUpdate = [SELECT ID, Amount__c, Date__c, Department__c, Client__c 
                                                 FROM Expense__c 
                                                 WHERE ID IN: setOfIds
                                                 AND(Amount__c > 500)];
        for (Expense__c exp : lstOfExpenseToUpdate)
        {
            exp.Amount__c = 500;       
        }        
        If(!lstOfExpenseToUpdate.isEmpty()){
            database.update(lstOfExpenseToUpdate);
        }
      //  String userEmail = [SELECT ID, Email FROM User WHERE ID =: UserInfo.getUserId()].name;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        mail.toAddresses = new String[] { UserInfo.getUserId()};
        mail.setTreatTargetObjectAsRecipient(true);
        mail.setReplyTo('support@acme.com');
        mail.setSenderDisplayName('Salesforce Support');
        mail.setSubject('Alert message for changes in amount');
        mail.setHtmlBody('your amount has been changes to 500 </b>');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}