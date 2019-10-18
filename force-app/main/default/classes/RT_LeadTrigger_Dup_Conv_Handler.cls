/*
@ClassName : RT_LeadTrigger_Dup_Conv_Handler
@JIRATicket : NA
@CreatedOn : 11/jun/2019
@ModifiedBy : Ganesh
@Description : Lead convertion of inserted lead and creating opportunity with out duplicates
*/
public class RT_LeadTrigger_Dup_Conv_Handler {
    public void afterInsert(Map<Id,Lead> insertedLeads){
        checkDuplicatesFieldValues(insertedLeads);
    }
    
    /*
* Method Name :checkDuplicatesFieldValues
* Params: Map<Id,Lead> mapOfLeadWithItsId
* Description: Avoiding duplicate leads and creating opportunities while inserting new leads
*/    
    public void  checkDuplicatesFieldValues(Map<Id,Lead> mapOfLeadWithItsId){
        Set<Id> setOfIds =  new Set<Id>();
        Map<String, Lead> mapOfLeadName = new Map<String, Lead>();
        Map<String, Lead> mapOfLeadEmail = new Map<String, Lead>();
        Map<String, Lead> mapOfLeadPhone = new Map<String, Lead>();
        for(Id leadIds: mapOfLeadWithItsId.keySet()){
            setOfIds.add(leadIds);
        }
        System.debug('setOfIds>>>>>>>'+setOfIds);
        
        //  List<lead> lstOfExistingLeads = [SELECT ID, LastName, Email, Phone FROM Lead WHERE ID NOT IN: setOfIds];
        //  System.debug('lstOfExistingLeads>>>>>>>'+lstOfExistingLeads);
        for(Lead ExistingLeads : [SELECT ID, LastName, Email, Phone FROM Lead WHERE ID NOT IN: setOfIds]){
            mapOfLeadName.put(ExistingLeads.LastName, ExistingLeads );
            mapOfLeadPhone.put(ExistingLeads.Phone, ExistingLeads);
            mapOfLeadEmail.put(ExistingLeads.Email, ExistingLeads);
        }
        
        List<Lead> leadsToBedeleted =  new List<Lead>();
        List<Lead> leadsToBeProcessed = new List<Lead>();
        
        for(Lead newleads: mapOfLeadWithItsId.Values()){
            System.debug('newleads>>>>>>>'+newleads);
            System.debug('newleadsPhone>>>>>>>'+newleads.Phone);
            System.debug('newleadsEmail>>>>>>>'+newleads.Email);
            if(String.isNotEmpty(newleads.LastName) && String.isNotEmpty(newleads.Phone) && String.isNotEmpty(newleads.Email)){
                
                if((mapOfLeadName.containsKey(newleads.LastName) && mapOfLeadPhone.containsKey(newleads.Phone)) ||
                   (mapOfLeadPhone.containsKey(newleads.Phone) && mapOfLeadEmail.containsKey(newleads.Email)) ||
                   (mapOfLeadEmail.containsKey(newleads.Email) && mapOfLeadName.containsKey(newleads.LastName))){
                       leadsToBedeleted.add(newleads);
                       leadsToBeProcessed.add(mapOfLeadName.get(newleads.LastName));
                   } else {
                       leadsToBeProcessed.add(newleads);
                   }
            } 
        }
        System.debug('>>>leadsToBedeleted>>>>'+leadsToBedeleted);
        System.debug('>>>leadsToBeProcessed>>>>'+leadsToBeProcessed);
        Set<Id> setIds = new Set<Id>();
        for(Lead led : leadsToBeProcessed){
            setIds.add(led.Id);
        }
         System.debug('>>>setIds>>>>'+setIds);
        //<<<<checking existing of opportunity before converting>>>>>>>>>>>>>
        Map<String, Opportunity> mapOfOpportunityName = new Map<String, Opportunity>();
        
        Map<Lead, boolean> mapOfLeadWithItsOpportunity = new Map<Lead, boolean>();
        
        for(Opportunity extopp : [SELECT ID, Name FROM Opportunity]){
             System.debug('>>>extopp.Name>>>>'+extopp.Name);
            mapOfOpportunityName.put(extopp.Name,extopp);
        }
        System.debug('>>>mapOfOpportunityName>>>>'+mapOfOpportunityName);
        for(Lead notconvleads : [SELECT ID, LastName, Company FROM Lead
                          WHERE IsConverted = False AND ID IN :setIds  ]){
                 System.debug('>>>notconvleads>>>>'+notconvleads);
                              if(mapOfOpportunityName.containsKey(notconvleads.Company)){
                                  mapOfLeadWithItsOpportunity.put(notconvleads,False);
                              }else{
                                  mapOfLeadWithItsOpportunity.put(notconvleads,True);
                              }
                          }
         System.debug('>>>mapOfLeadWithItsOpportunity>>>>'+mapOfLeadWithItsOpportunity);
        for(Lead leads : mapOfLeadWithItsOpportunity.keySet()){
              System.debug('>>>leads>>>>'+leads);  
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(leads.ID);
            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            System.debug('<<<convertStatus>>>'+convertStatus);
            lc.setConvertedStatus(convertStatus.MasterLabel);
            
            if(!mapOfLeadWithItsOpportunity.get(leads)){
                lc.setDoNotCreateOpportunity(TRUE);
            }else {
            Database.LeadConvertResult lcr = Database.convertLead(lc);
            System.debug('<<<lcr>>>'+lcr); 
            System.debug('<<<lcr.getOpportunityId()>>>'+lcr.getOpportunityId()); 
            }
            }
    }
}