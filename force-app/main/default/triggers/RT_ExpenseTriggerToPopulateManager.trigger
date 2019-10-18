trigger RT_ExpenseTriggerToPopulateManager on Expense__c (before insert, before update) {
    RT_ExpenseTriggerHandler_PM obj = new RT_ExpenseTriggerHandler_PM();
    if(Trigger.isInsert && Trigger.isBefore){
        
        obj.afterInsert(Trigger.new);
    }else if(Trigger.isUpdate && Trigger.isBefore){
        obj.afterInsert(Trigger.new);
    }
    
    
}