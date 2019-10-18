@isTest
public class RT_LeadTestClass{
    @testSetup static void setup() 
    {
        try{
            Lead ObjLead = new Lead();
            ObjLead.LastName = 'rak';
            ObjLead.Email='r@gmail.com';
            ObjLead.Phone='9876543210';
            ObjLead.Company = 'Hp';
            ObjLead.Status  = 'Closed Not Converted';
            Insert ObjLead;
            
            Lead ObjLead1 = new Lead();
            ObjLead1.LastName = 'rak1';
            ObjLead1.Email='r@gmail.com';
            ObjLead1.Phone='9876543210';
            ObjLead1.Company = 'Hp';
            ObjLead1.Status  = 'Closed Not Converted';
            Insert ObjLead1;
            
            Lead ObjLead3 = new Lead();
            ObjLead3.LastName = 'rak1';
            ObjLead3.Email='r@gmail.com';
            ObjLead3.Phone='9876543210';
            ObjLead3.Company = 'Hp';
            ObjLead3.Status  = 'Closed Not Converted';
            Insert ObjLead3;
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('Another lead has the same values,Please enter different values.') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        }
    }
    
}