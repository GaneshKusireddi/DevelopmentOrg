@RestResource(urlMapping='/RecordSubmit/*')
global class RT_OpportunityApprovalProcess {
    
    global class wrapperOfRecIdAndWorkItemId{
        String recId;
        List<Id> workItemIds;
        
        wrapperOfRecIdAndWorkItemId(String recId, List<Id> workItemIds){
            this.recId =recId;
            this.workItemIds = workItemIds;
        }
    }
    @httpPost
    global static wrapperOfRecIdAndWorkItemId doPost(String recId) {
        
        Id loggedInUserId = UserInfo.getUserId();
        //user managerDetail = 
        
        //User user1 = [SELECT Id FROM User WHERE Alias='Sy'];
        
        // Create an approval request for the account
        Approval.ProcessSubmitRequest req1 =  new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval');
        req1.setObjectId(recId);
        
        // Submit on behalf of a specific submitter
        req1.setSubmitterId(loggedInUserId); 
        
        // Submit the record to specific process and skip the criteria evaluation
        req1.setProcessDefinitionNameOrId('Discount_Approval_Process');
        req1.setSkipEntryCriteria(true);
        
        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);
        System.debug('>>>>>>>>'+result);
         System.debug('>>>>>>>>'+result.isSuccess());
        
        
        // First, get the ID of the newly created item
        List<Id> newWorkItemIds = result.getNewWorkitemIds();
        wrapperOfRecIdAndWorkItemId obj = new wrapperOfRecIdAndWorkItemId(recId,newWorkItemIds);
        return obj;
    }
}