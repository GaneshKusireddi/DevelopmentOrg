/*  
ClassName        : RT_AccountTriggerHandler
CreatedOn        : 15/04/2019
CreatededBy      : Ganesh
Description      : RT_AccountTriggerHandler to verify matching of two fields on Account 
LastModifiedOn   : 16/04/2019
ModifiedBy       : ganesh.
*/
public class RT_AccountTriggerHandler {
    public void beforeInsert(List<Account> lstAccounts){
        checkduplicates(lstAccounts);
        System.debug('Inside beforeInsert');
    }
    public void beforeUpdate(Map<Id, Account> mapNew,Map<Id, Account> oldMap ){
        checkduplicates(mapNew.values());
        System.debug('Inside beforeUpdate');
    }
    public void afterInsert(List<Account> lstAccounts,Map<Id, Account> newMap){
        System.debug('Inside afterInsert');
    }
    public void afterUpdate(Map<Id, Account> mapNew,Map<Id, Account> oldMap ){
        System.debug('Inside afterUpdate');
    }
/*
MethodName     : checkdiplicates
Param          : List<Account> lstAccounts
return         : void
Description    : Checking any 2 fields are matching.*/
    
    public void checkduplicates(List<Account> lstAccounts){
        for(Account Acc : lstAccounts){
            for(Account Acc1 : [select id,name,phone,website from Account]){
                if((Acc.name == Acc1.name && Acc.phone == Acc1.Phone) || (Acc.name == Acc1.name && Acc.website == Acc1.website)
                   || (Acc.website == Acc1.website && Acc.phone == Acc1.Phone)){
                    Acc.addError('Duplicate records are not allowed');
                }
            }
        }
    }
}















                /*
        Set<string> Setname= new Set<string>();
        Set<string> Setphone= new Set<string>();
        Set<string> Setwebsite= new Set<string>();
        set<string> dbNameSet = new set<string>();

    set<string> dbEmailSet = new set<string>();

        for(account acc : Trigger.new)
        {
            Setname.add(acc.name);
            setphone.add(acc.phone);
            setphone.add(acc.website);
        }
        for(Account dbAccount : [select name, phone, website 
                                 FROM Account 
                                 WHERE name IN: newNameSet OR phone IN: newPhoneSet OR website IN: newWebsiteSet])
       
          {
            
            dbNameSet.add(dbAccount.Name);
            
            dbPhoneSet.add(dbAccount.Phone);
            
            dbWebsiteSet.add(dbAccount.Website);
        }
         
         for(Account newAccount : trigger.new){
             
             if(dbNameSet.contains(newAccount.Name) && dbPhoneSet.Contains(newPhone.phone) 
                && dbWebsiteSet.Contains(newWebsite.Website))
                 
                 newAccount.addError('You are inserting Duplicate Account');
             
         }
        }
}*/