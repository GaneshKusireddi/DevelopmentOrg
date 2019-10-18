@isTest
public class RT_AccountHighlightPanelTest {
    @isTest
    public static void highlightPanelTest(){
        Account acc = new Account();
        acc.Name = 'ganesh';
        acc.AccountNumber = '123';
        acc.AccountSource = 'web';
        acc.AnnualRevenue = 20;
        acc.Phone = '9876543210';
        acc.Active__c = 'yes';
        insert acc;
        
        Account accid = [SELECT ID,Name FROM Account];
        System.assertEquals(6, RT_AccountHighlightPanel.getFieldSet(accid.ID).size());
    }
}