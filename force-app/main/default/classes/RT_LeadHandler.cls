/*
@ClassName : RT_LeadHandler
@JIRATicket : NA
@CreatedOn : 20/May/2019
@ModifiedBy : Ganesh
@Description : RT_LeadHandler is used to find duplicate fields while inserting  and to populate its id in paticular field.
*/
public class RT_LeadHandler {
    public void BeforeInsert(List<Lead> beforeinsertleads){
        System.debug('Inside beforeInsert');
        CheckDuplicatesFieldValues(beforeinsertleads); 
    }
    /*  public void BeforeUpdate(List<Lead> beforeinsertleads){
CheckDuplicatesFieldValues(beforeinsertleads); 
System.debug('Inside BeforeUpdate');
} */
    public void afterInsert(List<Lead> lstLead){
        PopulateLeadId(lstLead); 
        System.debug('Inside afterInsert');
    }
/* Method Name :CheckDuplicatesFieldValues
* Params: List<Lead> beforeinsertleads
* Description: To throw an error if any  duplicate values are inserting in three fields
*/    
    public void CheckDuplicatesFieldValues(List<Lead> beforeinsertleads){
        System.debug('Inside CheckDuplicatesFieldValues');
        Map<String, Lead> mapOfLeadwithName = new Map<String, Lead>();
        for(Lead Leads : [SELECT ID, LastName, Email, Phone FROM Lead]){
            System.debug('Leads'+Leads);
            mapOfLeadwithName.put(Leads.LastName, Leads);
            System.debug('>>>>>>>mapOfLeadwithName>>>>>>>>'+mapOfLeadwithName);
            for (Lead newleads : beforeinsertleads) {
                if((newleads.Email == Null) && (newleads.Phone == NUll)){
                    newleads.addError('Please enter email and phone values.');  
                } else {
                System.debug('<<<newleads>>>'+newleads);
                System.debug('<<<newleads.Name>>>'+newleads.LastName);
                System.debug('mapOfLeadwithName.get>>>>>'+mapOfLeadwithName.containsKey(newleads.LastName));
                if(mapOfLeadwithName.containsKey(newleads.LastName)){
                    System.debug('mapOfLeadwithName.get>>>>>'+mapOfLeadwithName.get(newleads.LastName));
                    if ((newleads.LastName == mapOfLeadwithName.get(Leads.LastName).LastName ) &&
                        (newleads.Email == mapOfLeadwithName.get(Leads.LastName).Email ) && 
                        newleads.Phone == mapOfLeadwithName.get(Leads.LastName).Phone ){
                            newleads.addError('Another lead has the '
                                              + 'same values,Please enter different values.');
                        } 
                }  else {
                    mapOfLeadwithName.put(Leads.LastName, Leads);
                }
               
               }
            }
        }
    }  
/* Method Name :PopulateLeadId
* Params: List<Lead> lstLead
* Description: To populate the lead id to paticular field
*/    
    public void PopulateLeadId(List<Lead> lstLead){
        List<Lead> leadToBeUpdated =  new List<Lead>();
        for(Lead leads : lstLead) {
            leadToBeUpdated.add(new Lead(Id = leads.Id, LeadId__c = leads.Id));
        }
        Database.update(leadToBeUpdated, false);
    }
}