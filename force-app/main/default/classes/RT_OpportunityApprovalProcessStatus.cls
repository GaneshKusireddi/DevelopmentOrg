@RestResource(urlMapping='/ApprovalStatus/*')
global class RT_OpportunityApprovalProcessStatus {

    @httpPost
    global static Boolean doPost(String recId, String WorkItemId, String status) {
          // Approve the submitted request
        // First, get the ID of the newly created item
       //list<Id> newWorkItemIds = result2.getNewWorkitemIds();
        
        // Instantiate the new ProcessWorkitemRequest object and populate it
        Approval.ProcessWorkitemRequest req2 =  new Approval.ProcessWorkitemRequest();
        req2.setComments('Approving request.');
       // req2.setObjectId(recId);
        req2.setAction(status);
      //req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        // Use the ID from the newly created item to specify the item to be worked
        req2.setWorkitemId(WorkItemId);
        
        // Submit the request for approval
        Approval.ProcessResult result2 =  Approval.process(req2);
        
        // Verify the results
        System.assert(result2.isSuccess(), 'Result Status:'+result2.isSuccess());
        return result2.isSuccess();
    }
}