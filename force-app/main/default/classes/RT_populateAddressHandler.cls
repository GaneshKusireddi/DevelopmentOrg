public class RT_populateAddressHandler {
    
    public void afterInsert(List<Contact> newContactList, Map<ID,Contact> newMap){ 
        UpdateAccountOnContactInsertion(newContactList, newMap); 
    }
    
    public void afterUpdate(List<Contact> newContactList, Map<ID,Contact> newMap){
        // List<Contact> UpdateList = new List<Contact>();
        // List<Account> CheckUpdatedAccount = new List<Account>();
        // UpdateList.addAll(OldList);
        // UpdateList.addAll(NewList);
        //UpdateAccountOnContactInsertion(UpdateList);
        UpdateAccountOnContactInsertion(newContactList,newMap); 
    } 
    
    
    Private void UpdateAccountOnContactInsertion(List<Contact> contactList, Map<ID, Contact> newMap){
        
        map<id, id> accountIdByContactId = new map<id, id>();
        for(Contact con: contactList){
            accountIdByContactId.put(con.AccountId, con.id);
        }
        List<Account> lstAccount = [SELECT id, BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry 
                                    from account 
                                    where id IN: accountIdByContactId.keyset()];
        List<Account> AccList = new List<Account>();
        for(Account a: lstAccount){
            Contact c = newMap.get(accountIdByContactId.get(a.id));
            
            if(c.MailingStreet != null && c.MailingStreet.isAlphanumericSpace()){
                a.BillingStreet = c.MailingStreet;
            }else{
                a.BillingStreet = null;
            } 
            
            if(c.MailingCity!=null && c.MailingCity.isAlpha()){
                a.BillingCity = c.MailingCity;
            }else{
                a.BillingCity = null;
            }
            
            if(c.MailingState!=null && c.MailingState.isAlpha()){
                a.BillingState = c.MailingState;
            }else{
                a.BillingState = null;
            }
            
            if(c.MailingPostalCode!=null && c.MailingPostalCode.isNumeric()){
                a.BillingPostalCode = c.MailingPostalCode;
            }else{
                a.BillingPostalCode = null;
            }
            
            if(c.MailingCountry!=null && c.MailingCountry.isAlpha()){
                a.BillingCountry = c.MailingCountry; 
            }else{
                a.BillingCountry = null; 
            } 
            
            AccList.add(a);
        }
        UPDATE AccList; 
    }
}