public class RT_ContentVersionTriggerHandler {
    public void BeforeInsert(List<ContentVersion> lstcontentversion){
        System.debug('>>>lstcontentversion>>>>>'+lstcontentversion);
        DeleteOldVersions(lstcontentversion); 
    }
    
    public void  DeleteOldVersions(List<ContentVersion> lstcontentversion){
        System.debug('>>>>>lstcontentversion>>'+lstcontentversion);
        Set<Id> contentDocumentIdSet = new Set<Id>();
        for(ContentVersion cv:lstcontentversion){
            if(cv.ContentDocumentId != null){
                contentDocumentIdSet.add(cv.ContentDocumentId);
            }
        }
        System.debug('>>>contentDocumentIdSet>>>>>'+contentDocumentIdSet);
        
       List<ContentDocument> lstOfDocumentTobeDeleted = [SELECT ID FROM ContentDocument WHERE ID IN :contentDocumentIdSet];
        System.debug('>>>lstOfDocumentTobeDeleted>>>>>'+lstOfDocumentTobeDeleted);
        // set of contentDocumentids which are deleted in further process.
        set<ID> conformLstContentDocuIDs = new set<ID>();
        for(ContentDocument oCD: lstOfDocumentTobeDeleted){
            conformLstContentDocuIDs.add(oCD.ID);
        }
        System.debug('>>>conformLstContentDocuIDs>>>>>'+conformLstContentDocuIDs);
         
        set<ID> lstLinkedEntityId = new set<ID>();
        Map<ID, list<ContentDocumentLink>> mapOfContentDocIdWithContentDocLinklst = new Map<ID, list<ContentDocumentLink>>();
        
        for(ContentDocumentLink CDL :[SELECT  ContentDocumentId, LinkedEntityId 
                                      FROM ContentDocumentLink 
                                      WHERE ContentDocumentId IN:contentDocumentIdSet]){
                                          
            mapOfContentDocIdWithContentDocLinklst.put(CDL.ContentDocumentId, new list<ContentDocumentLink>());
            
            lstLinkedEntityId.add(CDL.LinkedEntityId);
        }
        System.debug('>>>lstLinkedEntityId>>>>>'+lstLinkedEntityId);
        System.debug('>>>mapOfContentDocIdWithContentDocLinklst>>>>>'+mapOfContentDocIdWithContentDocLinklst);
        
        Set<ID> AccIDs = new Set<ID>();
        for(Account oA : [SELECT ID FROM Account WHERE ID IN : lstLinkedEntityId]){
            AccIDs.add(oA.ID);
        }
        System.debug('>>>AccIDs>>>>>'+AccIDs);

        list<ContentVersion> lstConVer = new List<ContentVersion>();
        for(ContentVersion oCV :[SELECT ID, ContentDocumentID, ContentLocation, oldContentDocID__c, Title, PathOnClient, VersionData
                                 FROM ContentVersion
                                 WHERE ContentDocumentID =: conformLstContentDocuIDs])
        {
            ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = oCV.ContentLocation;
            conVer.PathOnClient = oCV.PathOnClient;
            conVer.Title = oCV.Title ;
            conVer.VersionData = oCV.VersionData;
            conVer.oldContentDocID__c = oCV.ContentDocumentID;
            lstConVer.add(conVer); 
        }
        INSERT lstConVer;
        System.debug('>>>lstConVer>>>>>'+AccIDs);
        
        list<ID> lstRecordsToDeleteContentDoc = new list<ID>();
        list<ContentDocumentLink> lstRecordsToDeleteContentDocLink = new list<ContentDocumentLink>();
        list<ContentDocumentLink> lstContentDocLinkInsert = new list<ContentDocumentLink>();
        for(ContentVersion oCV: [SELECT ID, ContentDocumentId, oldContentDocID__c FROM ContentVersion WHERE id =: lstConVer ]){
            if(mapOfContentDocIdWithContentDocLinklst.containsKey(oCV.oldContentDocID__c)){
                for(ContentDocumentLink oCDL : mapOfContentDocIdWithContentDocLinklst.get(oCV.oldContentDocID__c)){
                    if(!AccIDs.contains(oCDL.LinkedEntityId)){
                        ContentDocumentLink cloneObject = oCDL.clone(false,false,false,false);
                        cloneObject.ContentDocumentId = oCV.ContentDocumentId;
                        cloneObject.ShareType = 'I';
                        lstContentDocLinkInsert.add(cloneObject);
                        lstRecordsToDeleteContentDocLink.add(oCDL); 
                    } 
                } 
                lstRecordsToDeleteContentDoc.add(oCV.oldContentDocID__c);
            }
        }
        INSERT lstContentDocLinkInsert;
        System.debug('>>>lstContentDocLinkInsert>>>>>'+lstContentDocLinkInsert);
        
        list<Id> lstContentversionRecDelete = new list<ID>();
        lstContentversionRecDelete.addAll( conformLstContentDocuIDs);
        Database.delete(lstContentversionRecDelete, false);
        Database.delete(lstRecordsToDeleteContentDocLink, false);
    
    }
}