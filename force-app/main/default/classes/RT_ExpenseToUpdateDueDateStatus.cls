global class RT_ExpenseToUpdateDueDateStatus implements Database.Batchable<sObject>, Database.Stateful {
    public List<Expense__c> listRecords = new List<Expense__c>();
    public List<String> lstOfEmails =  new List<String>();
    public string query;
    public Date DueDate;
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Date DueDate = System.today().addDays(+3);
        String query = 'Select Id,  Date__c, createdBy.Id From Expense__c where Date__c <=: DueDate';
        system.debug('<<<query>> '+query );
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Expense__c > scope){
        system.debug('scope'+scope);
        Set<Id> setOfUserIds = new Set<Id>();
        for(Expense__c obj : scope){
           // obj.Date__c <= 'DueDate';
            listRecords.add(obj);
            setOfUserIds.add(obj.createdBy.Id);
        }
       
        for(User users : [SELECT ID, Email FROM User WHERE ID IN:setOfUserIds]){
            lstOfEmails.add(users.Email);
        }
        system.debug('-------lstOfEmails---------'+lstOfEmails);
        update listRecords; 
    }
    
    global void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        mail.setToAddresses(lstOfEmails);
        mail.setCcAddresses(lstOfEmails);
        mail.setReplyTo('support@acme.com');
        mail.setSenderDisplayName('Salesforce Support');
        mail.setSubject('Alert message for the DueDates');
        mail.setPlainTextBody('Hai');
        mail.setHtmlBody('List of expenses </b>'+listRecords);
                        
        system.debug('-------listRecords----FINISH-----'+listRecords);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
     // Messaging.SendEmailResult[] results = Messaging.sendEmail(messages); 
    }
}

//Database.executeBatch(new RT_ExpenseToUpdateDueDateStatus());