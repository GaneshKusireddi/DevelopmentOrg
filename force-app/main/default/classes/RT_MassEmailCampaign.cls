public class RT_MassEmailCampaign {
    @AuraEnabled
    public static List < Campaign > fetchLookUpValues(String searchKeyWord, String ObjectName) {
        system.debug('ObjectName-->' + ObjectName);
        String searchKey = searchKeyWord + '%';
        
        List < Campaign > returnList = new List < Campaign > ();
        System.debug('returnList-->.'+returnList);
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5   
        String sQuery =  'select id, Name from  Campaign where Name LIKE: searchKey order by createdDate DESC limit 5';
        List < Campaign > lstOfRecords = Database.query(sQuery);
        system.debug('lstOfRecords-->' + lstOfRecords);
        for (Campaign obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
    @AuraEnabled
    public static void SendEmail(List<Campaign> CampaignRecord){
        
        List<contact> lstcon=[Select id from contact limit 2];
        List<Id> lstids= new List<Id>();
        for(Contact c:lstcon)
        {
            lstids.add(c.id);
        }
        EmailTemplate et=[Select id from EmailTemplate where name = 'EmailTemplatename' limit 1];
        
        Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        mail.setTargetObjectIds(lstIds);
        mail.setSenderDisplayName('System Admin');
        mail.setTemplateId(et.id);
        Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
        System.debug('CampaignRecord--->'+CampaignRecord);
    }
    
    @AuraEnabled
    public static List < sObject > cfetchLookUpValues(String ContactSearchKeyWord, String ObjectName, List<sObject> ExcludeitemsList) {
        String searchKey = '%' + ContactSearchKeyWord + '%';
        List < sObject > returnList = new List < sObject > ();
        
        List<string> lstExcludeitems = new List<string>();
        for(sObject item : ExcludeitemsList ){
            lstExcludeitems.add(item.id);
        }
        
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5 and exclude already selected records  
        String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey AND Id NOT IN : lstExcludeitems order by createdDate DESC limit 5';
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
}