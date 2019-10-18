/* TriggerName : RT_LeadTrigger
* CreatedOn : 20/May/2019
* LastModifiedOn : 21/May/2019
* CreatededBy : Ganesh
* ModifiedBy : Ganesh
* Description : trigger on before and after events to insert and update the lead fields
*/
trigger RT_LeadTrigger on Lead (Before Insert, Before Update, after Insert, after Update) {
    RT_LeadHandler obj= new RT_LeadHandler();
    
    // --Before Insert--
    System.debug('>>>>Binsert1>>');
    if(Trigger.IsBefore && Trigger.IsInsert){
        System.debug('>>>>Binsert2>>');
        obj.BeforeInsert(Trigger.new);
    }else if(Trigger.IsBefore && Trigger.isUpdate){
        // obj.BeforeUpdate(Trigger.old);
    }
    
    //--after insert--
    if(Trigger.IsAfter)
    {
        System.debug('>>>>insert1>>');
        if(Trigger.IsInsert)
        {
            obj.afterInsert(Trigger.new);
            System.debug('>>>>insert2>>');
        }
    }
    /*  else if(Trigger.isUpdate)
{
obj.afterUpdate(Trigger.old);
} */
}