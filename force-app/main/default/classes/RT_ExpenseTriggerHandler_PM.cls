public class RT_ExpenseTriggerHandler_PM {
    
    public void afterInsert(List<Expense__c> newExpenselst){
        PopulateUserManagerfieldtoExpense(newExpenselst);
    }
    
    private void PopulateUserManagerfieldtoExpense(List<Expense__c> newExpenselst){
        
        Id managerId = [SELECT Id, Manager.Id FROM User WHERE ID =:UserInfo.getUserId()].Manager.Id;
        for(Expense__c exp : newExpenselst){
            exp.Reporting_Manager__c = managerId;
            
        }
    }
}