trigger RT_FinancialRequestTrigger on Financial_Request__c (before insert,before update, after insert, after update) {

    RT_FinancialRequestTriggerHandler obj = new RT_FinancialRequestTriggerHandler();
    if(trigger.isBefore){
         if(trigger.isInsert){
        	obj.beforeInsert(Trigger.new);
    	}
        if(trigger.isUpdate){
        	obj.beforeupdate(Trigger.new);
    	}
    }
  if(trigger.isAfter){
         if(trigger.isInsert){
        	obj.afterInsert(Trigger.new);
    	}
        if(trigger.isUpdate){
        
    	}
    }
}