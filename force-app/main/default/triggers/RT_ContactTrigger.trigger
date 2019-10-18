trigger RT_ContactTrigger on Contact (before insert,after insert, before update, after update, after delete) {
    RT_ContactTriggerHandler obj = new RT_ContactTriggerHandler();
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            
            obj.beforeUpdate(trigger.newMap, trigger.oldMap);
        }else if(Trigger.isInsert){
            obj.beforeInsert(trigger.new);
        }
    }else if(Trigger.isAfter){
        if(Trigger.isUpdate){
            obj.afterUpdate(trigger.newMap, trigger.oldMap);
        }else if(Trigger.isInsert){
            obj.afterInsert(trigger.new, trigger.newMap);
        }
    }
}