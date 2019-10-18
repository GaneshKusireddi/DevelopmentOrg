/*
@ClassName : RT_Account_Add_Del_Rows_Dynamically
@JIRATicket : NA
@CreatedOn : 27-06-2019
@ModifiedBy : Ganesh 
@Description : To insert the list of account recordsfrom the Lightning page with add/delete rows dynamically
*/

public with sharing class RT_Account_Add_Del_Rows_Dynamically {

/*
* Method Name : saveAccounts
* Params: List<Account> accList
* Description: To check the duplicates of inserting records and with the existing records. 
*/    
    
    @AuraEnabled
    public static void saveAccounts(List<Account> accList){
        Insert accList;
        
        Set<Id> setOfNewlyCreatedAccIds =  new Set<Id>();
        for(Account Newacc: accList){
            setOfNewlyCreatedAccIds.add(Newacc.Id);
        }
        system.debug('<<setOfNewlyCreatedAccIds>>'+setOfNewlyCreatedAccIds);
        
        //checking duplicates of inserting records
        list<Account > Acclst = [select id,name,phone from Account where id in:setOfNewlyCreatedAccIds];
        
        Set<String> encounteredNames = new Set<String>();
        Set<String> encounteredphones = new Set<String>();
        
        List<Account> duplicateNameList = new List<Account>();
        
        for(Account aclst :Acclst){
            system.debug('aclst::'+aclst.id);    
            if(encounteredNames.contains(aclst.Name) && encounteredphones.contains(aclst.phone)){
                duplicateNameList.add(aclst);
            }else{
                encounteredNames.add(aclst.Name);
                encounteredphones.add(aclst.phone);
            }
        }
        system.debug('encounteredNames::'+encounteredNames);
        system.debug('encounteredphones::'+encounteredphones);
        system.debug('duplicateNameList::'+duplicateNameList);
        for(Account dupAcc: duplicateNameList){
            system.debug('dupAcc.id::'+dupAcc.id);
            
            Case c = new Case();
            c.Comments = 'Account with name and phone has alredy existed' ; 
            c.AccountId = dupAcc.Id ;
            insert c ;
            system.debug('<><c><>'+c);
        }
        
        //checking duplicates with existing records
            
        Map<String, Id> mapOfAccountNameWithItsId = new Map<String, Id>();
        Map<String, Id> mapOfAccountPhoneWithItsId = new Map<String, Id>();
        for(Account acc: [SELECT ID, Name, Phone FROM Account WHERE ID NOT IN:setOfNewlyCreatedAccIds]){
             system.debug('<<acc>>'+acc);
            mapOfAccountNameWithItsId.put(acc.Name, acc.ID);
            mapOfAccountPhoneWithItsId.put(acc.Phone, acc.ID);
        }
        system.debug('<<mapOfAccountNameWithItsId>>'+mapOfAccountNameWithItsId);
        system.debug('<<mapOfAccountPhoneWithItsId>>'+mapOfAccountPhoneWithItsId);
        
        for(Account newacc: accList){
            system.debug('<<newacc>>'+newacc);    
            if(mapOfAccountNameWithItsId.containsKey(newacc.Name) && mapOfAccountPhoneWithItsId.containsKey(newacc.Phone)){
                system.debug('<<mapOfAccountNameWithItsId.get(newacc.Name)>>'+mapOfAccountNameWithItsId.get(newacc.Name));
                system.debug('<<mapOfAccountPhoneWithItsId.get(newacc.Phone)>>'+mapOfAccountPhoneWithItsId.get(newacc.Phone));
                
                if(mapOfAccountNameWithItsId.get(newacc.Name) == mapOfAccountPhoneWithItsId.get(newacc.Phone)){
                    
                    Case c1 = new Case();
                    c1.Comments = 'Account with name and phone has alredy existed' ; 
                    c1.AccountId = newacc.Id ;
                    insert c1 ;
                    system.debug('<><c><>'+c1);
                    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setTemplateId([select Id from EmailTemplate where name ='DuplicateAccount'].Id);
                    email.setTargetObjectId(userinfo.getUserId());
                    email.setSaveAsActivity(false);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
                    system.debug('<<userinfo.getUserId()>>'+userinfo.getUserId());
                }
            }
        }
    }
}