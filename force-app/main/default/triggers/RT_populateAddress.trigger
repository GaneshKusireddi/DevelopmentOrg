trigger RT_populateAddress on Contact (after insert, after update) {
RT_populateAddressHandler obj1 = new RT_populateAddressHandler();
     if(Trigger.isAfter){
        //insert
        if(Trigger.isInsert){
            obj1.afterInsert(Trigger.new,Trigger.newMap);
        }
        //update
        else if(Trigger.isUpdate)
        {
            obj1.afterUpdate(Trigger.new, Trigger.newMap);
                   } 
        
     }
}