global class RT_script_to_insert_records implements Database.Batchable<sObject> {

    
    global Iterable<sObject> start(Database.BatchableContext BC){
    List<sObject> sList=new List<sObject>();
    List<Opportunity> oppList=[Select id, isProcessed__c from Opportunity where isProcessed__c =false Limit 20000];
    List<Contact> conList=[Select id, isProcessed__c from Contact where isProcessed__c=false Limit 20000];
 System.debug('oppList----->'+oppList);

     for(Integer i=0;i<oppList.size() && i<conList.size();i++){
        OpportunityContactRole ocr=new OpportunityContactRole(OpportunityId=oppList[i].Id, Role  = 'Decision Maker',ContactId=conList[i].Id);
        sList.add(ocr);
        sList.add(oppList[i]);
        sList.add(conList[i]);
    }
    return sList;     
}
/**
 * Name : execute
 * Description : process batches
 **/
global void execute(Database.BatchableContext BC, List<sObject> scope){
    List<Opportunity> tempOppList=new List<Opportunity>();
    List<Contact> tempConList=new List<Contact>();
    List<OpportunityContactRole> ocrList= new List<OpportunityContactRole>();

    for(sObject s:scope){
        if(s.getSObjectType().getDescribe().getName()=='Contact'){
            Contact c=(Contact)s;
            c.isProcessed__c=true;
            tempConList.add(c);
        }
        else if(s.getSObjectType().getDescribe().getName()=='Opportunity'){
            Opportunity o=(Opportunity)s;
            o.isProcessed__c=true;
            tempOppList.add(o);
        }
        else{
            OpportunityContactRole o=(OpportunityContactRole)s;
            ocrList.add(o);
        }
    }
    //if list is not blank then delete all records
   if(tempOppList!=null){
    update tempOppList;
   }
   if(tempConList!=null){
    update tempConList;
   }
   if(ocrList!=null){
       insert ocrList;
   }

     System.debug('ocrList----->'+ocrList);



}
/**
 * Name : finish
 * Description :finish method for post processing. 
 **/
global void finish(Database.BatchableContext BC){
        List<sObject> sL=[Select Id from Opportunity where isProcessed__c=false limit 1];

        if(sL!= null){
    //execute batch again
        RT_script_to_insert_records batch = new RT_script_to_insert_records();
        Database.executeBatch(batch,5000);
        }
     System.debug('finish----->');

    }
}