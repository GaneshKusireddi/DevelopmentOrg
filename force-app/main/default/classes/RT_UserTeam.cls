public with sharing class RT_UserTeam {
    @AuraEnabled
    public static void saveUserdetails(UserTeam__c Userdetails,String recID){
        system.debug('<<Userdetails>>'+Userdetails);
        Userdetails.UserName__c =recID;
        system.debug('>>>>>>'+recID);
        Insert Userdetails;
    }
    
    @AuraEnabled
    public static  List<String> getProfiles(){
        List<String> profileNames = new List<String>();
        for(Profile pro: [SELECT Id, Name FROM Profile]){
            profileNames.add(pro.Name);
        }
        return profileNames;
    }
    
    @AuraEnabled
    public static List <User> fetchUsers(String searchKeyWord) {
        System.debug('>>>>>searchKeyWord>>>'+searchKeyWord);
        String searchKey = searchKeyWord + '%';
        List < User > lstOfuser = [select id, Name from User where Name LIKE: searchKey];
        System.debug('>>>>>lstOfuser>>>'+lstOfuser);
        return lstOfuser;
    }
    @AuraEnabled
    public static List<UserTeam__c> getUserRecords() {
        System.debug('>>>>>getUserRecords>>>');
        Id loggedInID = userInfo.getUserId();
        return [Select Id, FirstName__c,LastName__c,Phone__c,Email__c,UserName__r.name,Profile__c  
                From UserTeam__c
                WHERE UserName__c =: loggedInID ];
    }
     
}