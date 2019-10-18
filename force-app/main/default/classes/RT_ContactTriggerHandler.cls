/**  
ClassName        : RT_ContactTriggerHandler
CreatedOn        : 15/April/2019
CreatededBy      : Anup
Description      : update Email Field.
LastModifiedOn   :
ModifiedBy       : 
*/

public class RT_ContactTriggerHandler {

    public void beforeInsert(List<Contact> lstContacts){
        updateEmailField(lstContacts);
        System.debug('Inside beforeInsert');
    }
    public void beforeUpdate(Map<Id, Contact> mapNew,Map<Id, Contact> oldMap ){
         updateEmailField(mapNew.values());
        System.debug('Inside beforeUpdate');
    }
    public void afterInsert(List<Contact> lstContacts,Map<Id, Contact> newMap){
        System.debug('Inside afterInsert');
    }
    public void afterUpdate(Map<Id, Contact> mapNew,Map<Id, Contact> oldMap ){
        System.debug('Inside afterUpdate');
    }
    /**
    @MethodName     : updateEmailField
    @Param          : List<Contact> lstContacts
    @return         : void
    @Description    : Updating Email Field.
    **/
    public void updateEmailField(List<Contact> lstContacts){
        for(Contact objCon : lstContacts){
            if(objCon.Email == null){
                objCon.Email = 'fake@fake.com';
            }
        }
    }
}