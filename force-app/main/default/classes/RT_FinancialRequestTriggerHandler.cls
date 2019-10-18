/*
@ClassName    : RT_populateCasedetailsHandler
@JIRATicket   : NA
@CreatedOn    : 29/04/2019
@ModifiedBy   : Ganesh
@Description  : Create a class to handle the trigger with a Detailsofcaseid-method. 
*/

public class RT_FinancialRequestTriggerHandler
{
    //beforeinsert
    public void beforeInsert(List<Financial_Request__c> lstfr){
        Detailsofcaseid(lstfr); 
        System.debug('Inside beforeInsert');
    }
    //beforeupdate
    public void beforeupdate(List<Financial_Request__c> lstfr){
        Detailsofcaseid(lstfr); 
        System.debug('Inside beforeUpdate');
    }
    // after insert
    public void afterInsert(List<Financial_Request__c> lstFRequests){
         attachingFiles(lstFRequests); 
        System.debug('Inside afterInsert');
    }
    
    
    /*
* Method Name: Detailsofcaseid
* Params     : List
* Description: To get the casecomments and attachments with the caseid
*/
    public void  Detailsofcaseid(List<Financial_Request__c> lstfr)
    {
        Set<Id> frIds = new Set<Id>();
        system.debug('...'+frIds);
        for(Financial_Request__c fr1 : lstfr)
        {
            if(fr1.Historical_CaseId__c != null && fr1.Historical_CaseId__c.startsWith('500')){
                frIds.add(fr1.Historical_CaseId__c);
            } 
            
        }
        
        map <Id, List<CaseComment>> mapCaseidtocasecomments = new map<Id, List<CaseComment>>(); 
        
        if(!frIds.isEmpty()){ 
            system.debug('.qwqwqw..'+frIds);
            for(CaseComment objCaseComment: [SELECT Id, parentId, CreatedBy.Name, CreatedDate, CommentBody 
                                             FROM CaseComment
                                             WHERE parentId IN :frIds])
            {   
                if(!mapCaseidtocasecomments.containsKey(objCaseComment.parentId)){
                    mapCaseidtocasecomments.put(objCaseComment.parentId, new List<CaseComment> {objCaseComment});
                }
                mapCaseidtocasecomments.get(objCaseComment.parentId).add(objCaseComment);
            }
        }
        
        
        for(Financial_Request__c fr1 : lstfr)
        { 
            if(fr1.Historical_CaseId__c != null && fr1.Historical_CaseId__c != '')
            {
                /*if(fr1.Historical_CaseId__c.startsWith('500'))
// if(fr1.Historical_CaseId__c.startsWith('500'))
{*/
                List<CaseComment> lstcasecomments = mapCaseidtocasecomments.get(fr1.Historical_CaseId__c);
                system.debug('lstcasecomments--->'+lstcasecomments );
                string comment='';
                for(CaseComment cm: lstcasecomments)
                {
                    comment += ' Createdby name:' + cm.CreatedBy.Name +'\n'+ 'CreatedDate:'+ cm.CreatedDate +'\n'+ 'CaseCommentsbody:'+ cm.CommentBody + '\n'+'\n';
                    
                } system.debug('...'+lstcasecomments);
                fr1.Internal_Comments__c += comment; 
                // update lstcasecomments;
                //}/*else{
                /*  fr1.adderror('Invalid Id');
fr1.Internal_Comments__c = ' ';
}*/
            } 
            else{
                fr1.Internal_Comments__c = ' ';
            }
        }  
    }
    
   // For Attaching Files
    public void attachingFiles(List<Financial_Request__c> lstFRequests) {
        Set<String> HistoricalId=new Set<String>();
        for(Financial_Request__c fr:lstFRequests){
            HistoricalId.add(fr.Historical_CaseId__c);
        }
        
        map<Id, List<Attachment>> lstAttachmentsByCaseId = new map<Id, List<Attachment>>();
        for(Attachment objAtt : [Select Id, ParentId, Name,Body 
                                 From Attachment 
                                 WHERE ParentId = :HistoricalId])
        {
            if(!lstAttachmentsByCaseId.containsKey(objAtt.ParentId)){
                lstAttachmentsByCaseId.put(objAtt.ParentId, new List<Attachment>());
            }
            lstAttachmentsByCaseId.get(objAtt.ParentId).add(objAtt);
            
        }
        List<Attachment>lstAttachtoInsert = new List<Attachment>();
        for(Financial_Request__c objFr : lstFRequests){
            
            List<Attachment> lstAttachment = lstAttachmentsByCaseId.get(objFr.Historical_CaseId__c);
            System.debug('<<<Attactlist>>'+lstAttachment);
            if(objFr.Historical_CaseId__c != null){
                for(Attachment att : lstAttachment){
                    Attachment at = new Attachment();
                    at.name = att.name;
                    at.body = att.body;
                    at.parentid = objFr.Id;
                    lstAttachtoInsert.add(at);
                    
                }
            }
            if(!lstAttachtoInsert.isEmpty())
                INSERT lstAttachtoInsert;
        }
        
    }
}
    
    
    /*
    public void  AttachmentstoFR(List<Financial_Request__c> lstfr)
    {   
        //  List<Attachment> insertAttList = new List<Attachment>();
        
        Set<id> parentRecordId = new  Set<id>();
        system.debug('...'+parentRecordId);
        for(Financial_Request__c fr1 : lstfr)
        {
            parentRecordId.add(fr1.Historical_CaseId__c);
        }
        
        Map<id, List<Attachment>> lstAttachmentsBycaseid= new Map<id, List<Attachment>>();
        
        for(Attachment att : [SELECT id, name,parentId, body 
                              FROM Attachment
                              WHERE ParentId in :parentRecordId ])
        {
            {
                if(!lstAttachmentsBycaseid.containsKey(att.ParentId)){
                    lstAttachmentsBycaseid.put(att.ParentId, new List<Attachment>());
                }
                lstAttachmentsBycaseid.get(att.ParentId).add(att);
                
            }
            /*
if(!lstAttachmentsBycaseid.containsKey(att.parentId) )
{
List<Attachment> t = lstAttachmentsBycaseid.get(att.parentId);
t.add(att);
lstAttachmentsBycaseid.put(att.parentId,t);
}else{
List<Attachment> t = new List<Attachment>();
t.add(att); 
lstAttachmentsBycaseid.put(att.parentId,t);
}

        }
        
        List<Attachment>lstAttachtoInsert = new List<Attachment>();
        for(Financial_Request__c objFr : lstfr){
            
            List<Attachment> lstAttachment = lstAttachmentsByCaseId.get(objFr.Historical_CaseId__c);
            System.debug('<<<Attactlist>>'+lstAttachment);
            if(objFr.Historical_CaseId__c != null){
                for(Attachment att : lstAttachment){
                    Attachment at = new Attachment();
                    at.name = att.name;
                    at.body = att.body;
                    at.parentid = objFr.Id;
                    lstAttachtoInsert.add(at);
                    
                }
            }
            if(!lstAttachtoInsert.isEmpty())
                INSERT lstAttachtoInsert;
        }
    }
}



/*   for(String s : lstAttachmentsBycaseid.keySet())
{
for(Attachment a :lstAttachmentsBycaseid.get(s))
{
Attachment  b = a.clone();
b.parentid = Trigger.newMap.get(s).ID;
insertAttList.add(b); 
}
}

if(insertAttList.size()>0)
insert insertAttList;

} 
*/