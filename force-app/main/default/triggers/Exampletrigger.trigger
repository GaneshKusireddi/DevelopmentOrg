trigger Exampletrigger on Contact (after insert,after delete) {

    if (trigger.isInsert && trigger.isAfter){
        Account acc = new Account();
        acc=[select id,NumberofLocations__c from account where id=:trigger.new[0].accountId];

        list<contact> contsize = new list<contact>();
        contsize = [ select id,lastname from contact where accountId = :trigger.new[0].accountId];

        acc.NumberofLocations__c = contsize.size();

        update acc;

    }
    if(trigger.IsDelete && trigger.isAfter){

        Account acc = new Account();

        acc=[select id,NumberofLocations__c from account where id=:trigger.old[0].accountId];

        list<contact> contsize = new list<contact>();

        contsize = [ select id,lastname from contact where accountId = :trigger.old[0].accountId];

        acc.NumberofLocations__c = contsize.size();

        update acc;

         
    }  
}