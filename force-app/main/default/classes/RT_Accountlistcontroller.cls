public class RT_Accountlistcontroller {
@AuraEnabled
public static List<Account> getAccount() {
   return [Select Id, Name, Phone , Type From Account LIMIT 10];
}

}