public class RT_AccountHighlightPanel {
    
    @AuraEnabled
    public static List<Fieldsetwrapper>  getFieldSet(Id recId){
        
        List<Fieldsetwrapper> lstFieldsetwrapper = new List<Fieldsetwrapper>();
        List<String> lstOfApiNames =  new List<String>();
        
        String SobjectName = String.valueOf(recId.getSobjectType());
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe();
        system.debug('SobjectName ====>' + SobjectName);
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(SobjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get('Account_Field_set');
        
        for(Schema.FieldSetMember fieldSetMemberObj : fieldSetObj.getFields())
        {	
            lstOfApiNames.add((String)fieldSetMemberObj.getFieldPath());
        }
        
        String query ='SELECT '+String.join(lstOfApiNames, ',') +' FROM '+SobjectName +' WHERE ID =\''+recId+'\'';
        System.debug('>>>>query>>>>'+query);
        Account acc = database.query(query);
        system.debug('acc ====>' + acc);
        
        for(Schema.FieldSetMember fieldSetMemberObj : fieldSetObj.getFields())
        {	
            System.debug('>>>apiname>>>'+(String)fieldSetMemberObj.getFieldPath());
            System.debug('>>fieldtype>>>>'+fieldSetMemberObj.getType());
            if(String.valueOf(fieldSetMemberObj.getType()) == 'CURRENCY'){
              
                String apiName = (String)fieldSetMemberObj.getFieldPath();
                Decimal str = (Decimal)acc.get(apiName);
                String str1 = String.valueOf(str);
                System.debug('>>>>>>>>>'+ str);
                System.debug('>>>>>>>>>'+ str1);
                lstFieldsetwrapper.add(new Fieldsetwrapper((String)fieldSetMemberObj.getLabel(), '$'+str1));
               
            } else{
                String apiName = (String)fieldSetMemberObj.getFieldPath();
                System.debug('>>>>>>'+(String)acc.get(apiName));
                lstFieldsetwrapper.add(new Fieldsetwrapper((String)fieldSetMemberObj.getLabel(), (String)acc.get(apiName))); 
            }
       }
        system.debug('lstOfApiNames ====>' + lstOfApiNames);
        system.debug('lstFieldsetwrapper ====>' + lstFieldsetwrapper);
        return lstFieldsetwrapper;
    }
    // wrapper class
    public class Fieldsetwrapper{
        @AuraEnabled
        public String Fieldsetlabel;
        @AuraEnabled
        public String FieldsetValue; 
        Fieldsetwrapper(String Fieldsetlabel, String FieldsetValue){
            this.Fieldsetlabel = Fieldsetlabel;
            this.FieldsetValue = FieldsetValue;
        }
    }
}