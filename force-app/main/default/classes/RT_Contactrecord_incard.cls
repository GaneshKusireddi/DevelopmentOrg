/*
@ClassName : RT_Contactrecord_incard
@JIRATicket : NA
@CreatedOn : 17/07/0219
@ModifiedBy : Ganesh
@Description : To send User,Conatcts and records,emails to the client side controller
*/

public with sharing  class RT_Contactrecord_incard {
    /*
* Method Name :getUser()
* Params: NA
* Description: To return the current user name.
*/
    @AuraEnabled
    public static String getUser() {
        string Username = userInfo.getName();
        System.debug('>>>>>getUser>>>'+Username);
        return Username ;
    }
//Returns list of contacts    
    @AuraEnabled
    public static List<Contact> getContacts() {
        return [select id, Name, Account.name from Contact];
    }
//Delete contact by contactid(conid)   
    @AuraEnabled
    public static void deleteContactById(String conid){
        System.debug('In controller deleteContactById method..'+conid);
        Contact delContact=[Select Id from Contact where id=:conid];
        delete delContact;
    }
//Returns list of Active Users by Searchkey  
    @AuraEnabled
    public static list< User>  fetchUsers(String searchKeyWord){
        system.debug('searchKeyWord'+searchKeyWord);
        String searchkey = searchKeyWord+'%';
        return [select id ,Name from User where name like :searchkey AND IsActive = true];
    }
//Returns contact record by contactid, updates changed owner of contact by selected ownerid
//Sends an email if email checkbox is Ischecked     
    @AuraEnabled
    public static Contact changeContactOwner( String selectedUId, Boolean Ischecked, String contactId){
        
        Contact conDetail = [SELECT ID, Owner.Id, createdBy.Id FROM Contact WHERE Id =:contactId];
        String oldUserEmail = [SELECT Id, Email FROM User WHERE ID =: conDetail.CreatedById].Email;
        system.debug('before updation oldUserEmail--->'+oldUserEmail);
        system.debug('before updation conDetail--->'+conDetail);
        
        update new Contact(Id=conDetail.Id, OwnerId=selectedUId);
        
        Contact conDetailAfterUpdate = [SELECT ID, Owner.Id, createdBy.Id FROM Contact WHERE Id =:contactId];
        system.debug('after updation conDetail--->'+conDetailAfterUpdate);
        
        if(Ischecked==true){ 
            String[] toAddress = new String []{oldUserEmail};
            String body = '<html><head><title>"Contact Owner is Changed."</title></head>';
            body+='<body><h2>Kindly pay attention, one of the contact owner is changed.</h2>'; 
            body+='</body></html>'; 
            Messaging.reserveSingleEmailCapacity(1);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddress);
            mail.setreplyto('mani.manu.19.c@gmail.com'); //TODO
            mail.setSubject('Attention!!! Contact Owner is changed!');
            mail.setSenderDisplayName('Salesforce Support'); 
            mail.setHtmlBody(body);
            mail.setSaveAsActivity(false);
            // Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {mail};
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages); 
            if(results[0].success) 
            {
                System.debug('The email was sent successfully.');
            }else{
                System.debug('The email failed to send: ' + results[0].errors[0].message);
            } 
        } 
        return conDetail;
    } 
}