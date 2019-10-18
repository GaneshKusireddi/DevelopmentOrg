trigger RT_ContentVersionTrigger on ContentVersion (Before Insert) {
    RT_ContentVersionTriggerHandler obj= new RT_ContentVersionTriggerHandler();
if(Trigger.IsBefore && Trigger.IsInsert){
        System.debug('>>>>Binsert2>>');
        obj.BeforeInsert(Trigger.new);
    }
}