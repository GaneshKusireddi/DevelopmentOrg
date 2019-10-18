public class RT_EmployeeTablecontroller {
    @AuraEnabled
    public static List<Employee__c> getEmployees() {
        return [Select Id, Name, Phone__c, Email__c, Country__c From Employee__c LIMIT 10];
    }
     @AuraEnabled
     public static void updateEmployee(Employee__c upemps ){
         update upemps;
        }
}