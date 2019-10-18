trigger RT_NumberofContacts on Contact (after insert,after update, after delete) {
 RT_NumberofContactsHandler obj = new RT_NumberofContactsHandler(); 
    
    if(Trigger.isAfter){
        //insert
        if(Trigger.isInsert){
            obj.afterInsert(Trigger.new);
        }
        //update
        else if(Trigger.isUpdate)
        {
            obj.afterUpdate(Trigger.new);
            obj.afterdelete(Trigger.old);
        } 
        //delete
        else if(Trigger.isdelete)
        {
            obj.afterdelete(Trigger.old);
        }
    }
}