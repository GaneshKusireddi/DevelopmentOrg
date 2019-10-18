@istest
public class RT_Account_Add_Del_Rows_DynamicallyTest {
    @isTest(SeeAllData='true')
    public static void duplicateRecTest(){
        List <Account> accList = new List <Account>();
        Account Acc = new Account();
        Acc.Name='Ganesh';
        Acc.phone='0123';
        accList.add(Acc);
        
        Account Acc1 = new Account();
        Acc1.Name='Ganesh';
        Acc1.phone='0123';
        accList.add(Acc1);
        
        Account Acc2 = new Account();
        Acc2.Name='ZZZ';
        Acc2.phone='1758';
        accList.add(Acc2);
        
        Account Acc3 = new Account();
        Acc3.Name='ABC';
        Acc3.phone='654654';
        accList.add(Acc3);
        
        RT_Account_Add_Del_Rows_Dynamically.saveAccounts(accList);
    }
    
}