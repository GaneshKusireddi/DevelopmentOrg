trigger RT_AccountTrigger on Account(before insert, before update) {
   RT_AccountTriggerHandler obj = new RT_AccountTriggerHandler();
    {
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
}