@isTest
public class RT_ObjectsMetaDataTestclass {
    static testMethod void validateHelloWorld() {
        Account acc = new Account(Name = 'test');
        insert acc;
        String sObjName = acc.Id.getSObjectType().getDescribe().getName();
        System.assertEquals('Account',sObjName );
        RT_ObjectsMetadataController obj = new RT_ObjectsMetadataController();
        RT_ObjectsMetadataController.FetchMetaData(sObjName);
        
        System.assertEquals(1, [SELECT Count() FROM Account]);
        
        
    }
}