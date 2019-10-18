/* TriggerName : RT_LeadTriggerDuplication_Convertion
* CreatedOn : 11/jun/2019
* LastModifiedOn : 13/jun/2019
* CreatededBy : Ganesh
* ModifiedBy : Ganesh
* Description : Trigger to lead convertion 
*/
trigger RT_LeadTriggerDuplication_Convertion on Lead (after insert) {
    RT_LeadTrigger_Dup_Conv_Handler obj = new RT_LeadTrigger_Dup_Conv_Handler();
    
    if(Trigger.isAfter && Trigger.isInsert){
        obj.afterInsert(Trigger.newMap);
    }
}