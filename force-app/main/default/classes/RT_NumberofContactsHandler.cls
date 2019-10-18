/*  
ClassName        : RT_NumberofContactsHandler
CreatedOn        : 16/04/2019
CreatededBy      : Ganesh
Description      : RT_NumberofContactsHandler to count no of contacts of an Account 
LastModifiedOn   : 
ModifiedBy       : 
*/
public class RT_NumberofContactsHandler {
    //afterinsert
    public void afterInsert(List<Contact> lstContact){
        NumberofContacts(lstContact); 
        System.debug('Inside afterInsert');
    }
    //afterupdate
    public void afterUpdate(List<Contact> lstContact){
      NumberofContacts(lstContact); 
        System.debug('Inside afterUpdate');
    }
    //afterdelete
    public void afterdelete(List<Contact> lstContact){
        NumberofContacts(lstContact); 
        System.debug('Inside afterdelete');
    }
/*
MethodName     : Number of conatacts
Param          : List<Account> lstAccount
return         : void
Description    : To count no of contacts in an Account 
*/
    public void NumberofContacts(List<Contact> lstContact){

       List<Contact> contacts = Trigger.isDelete ? Trigger.old : Trigger.new;
        Set<Id> acctIds = new Set<Id>();
        for (Contact c : lstContact) {
             if (c.AccountId != null) {
               acctIds.add(c.AccountId);
             } 
        }
        List<Account> Acc = new List<Account>();
        for (AggregateResult ar : [SELECT AccountId AcctId, Count(id) ContactCount
                                   FROM Contact
                                   WHERE AccountId in: acctIds
                                   GROUP BY AccountId])
                                {
                                       Account a = new Account();
                                      a.Id = (Id) ar.get('AcctId'); 
                                      a.NumberofLocations__c = (Integer) ar.get('ContactCount');
                                       Acc.add(a);
                                   }
        update Acc;
    }
}