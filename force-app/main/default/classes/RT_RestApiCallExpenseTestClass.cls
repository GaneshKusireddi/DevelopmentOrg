@isTest
public class RT_RestApiCallExpenseTestClass {
    static testMethod void testPostMethod()
    {
        RestRequest request = new RestRequest();
        // request.requestUri ='https://ganeshraagvitech-dev-ed.my.salesforce.com/services/apexrest/Expense__c/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json'); 
        Account acc = new Account(Name= 'Test');
        Insert acc;
        RestContext.request = request;
        List<Expense__c> lstOfExpenses = new List<Expense__c>{
            new Expense__c(Amount__c = 300,Expense_Type__c ='dues', Client__c = acc.Id, Date__c = Date.parse('06/05/19'), Department__c = 'CSE'),
                new Expense__c(Amount__c = 400,Expense_Type__c ='dues', Client__c = acc.Id, Date__c = Date.parse('06/05/19'), Department__c = 'CSE'),
                new Expense__c(Amount__c = 600,Expense_Type__c ='dues', Client__c = acc.Id, Date__c = Date.parse('06/05/19'), Department__c = 'CSE')
                };
                    insert lstOfExpenses;
        List<String> lstOfIds =  new List<String>();
        for(Expense__c exp : lstOfExpenses){
            lstOfIds.add(exp.Id);
        }
        /*Expense__c exp = new Expense__c();
exp.Amount__c = 300;
exp.Client__c = 'ABC';
exp.Date__c = Date.parse('06/05/19');
exp.Department__c = 'CSE';
Insert exp;
Expense__c exp1 = new Expense__c();
exp1.Amount__c = 800;
exp1.Client__c = 'gan';
exp1.Date__c = Date.parse('01/05/19');
exp1.Department__c = 'ECE';
Insert exp1;
Expense__c exp2 = new Expense__c();
exp2.Amount__c =100;
exp2.Client__c = 'siva';
exp2.Date__c = Date.parse('09/05/19');
exp2.Department__c = 'CSE';
Insert exp2; 
Expense__c exp3 = new Expense__c();
exp3.Amount__c = 1000;
exp3.Client__c = 'ABC';
exp3.Date__c = Date.parse('06/05/19');
exp3.Department__c = 'MEC';  
Insert exp3; 
List<String> ExpenseIds = new list<String>();
ExpenseIds.add(exp.Id);
ExpenseIds.add(exp1.Id);
ExpenseIds.add(exp2.Id);
ExpenseIds.add(exp3.Id);*/
RT_RestApiCallOnExpense.doPost(lstOfIds); 
    }
}
/*   List<String> ExpenseIds = new list<String>();
ExpenseIds.add('a000K00001q7VQz');
ExpenseIds.add('a000K00001q7VLk');
ExpenseIds.add('a000K00001q7VVQ');
ExpenseIds.add('a000K00001q7cI7');
ExpenseIds.add('a000K00001q7SKE');
ExpenseIds.add('a000K00001q78Eu');
ExpenseIds.add('a000K00001q7ffd');
RT_RestApiCallOnExpense.doPost(ExpenseIds);
System.assert(ExpenseIds !=null );
*/



/*   Test.startTest();
RestRequest req = new RestRequest(); 
RestResponse res = new RestResponse();
req.requestURI = 'https://ganeshraagvitech-dev-ed.my.salesforce.com/services/apexrest/Expense__c/'; 
req.params.put('phoneNumber', '9876543210');
req.httpMethod = 'POST';
req.addHeader('Content-Type', 'application/json'); 

String strId = MyFirstRestAPIClass.doPost('Amit','2345678','12345');

RestContext.request = req;
RestContext.response = res;
Expense__c usr1 = RT_RestApiCallOnExpense.doPost();
System.debug(usr1);
Test.stopTest();   */