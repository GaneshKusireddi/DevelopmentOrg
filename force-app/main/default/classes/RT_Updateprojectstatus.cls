global class RT_Updateprojectstatus implements Database.Batchable<sObject> {
    Date todaysDate = System.today();
    String status ='Close';
   string query = 'SELECT ID, Name, ExpireDate__c, Status__c FROM project__c WHERE ExpireDate__c <=:'+todaysDate+' AND Status__c !='+status;

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<project__c> scope){
       System.debug('>>>>>>'+scope);
       List<project__c> ProjectStatusUpdate = new List<project__c>();
       for(project__c pro : scope){
           
            pro.status__c = 'close';
            ProjectStatusUpdate.add(pro);
       }
       update ProjectStatusUpdate;
   }

   global void finish(Database.BatchableContext BC){
   }
}


/*
global class RT_Updateprojectstatus implements Database.Batchable<sObject> {
    //global string query;
    global Database.QueryLocator start(Database.BatchableContext BC) {
        //System.debug('Select Id, project Name__c,Expire Date__c,status__c From Projects__c Where Expire Date__c <:'+ date.today() + 'AND status__c !="close" ');
        
        return Database.getQueryLocator('Select Id, project Name__c,Expire Date__c,status__c From Projects__c Where Expire Date__c <:'+ date.today() + 'AND status__c !="close" ');
      }
    
    global void execute(Database.BatchableContext BC, List<projects__c> scope) {
        List<projects__c> ProjectStatusUpdate = new List<projects__c>();
        for(projects__c ps : scope)
        {
            ps.status__c = 'close';
            ProjectStatusUpdate.add(ps);
            update ProjectStatusUpdate;
        }
    }
    global void finish(Database.BatchableContext BC)
    {}
} 
*/