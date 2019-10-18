/*
@ClassName : RT_ObjectsMetadataController
@JIRATicket : NA
@CreatedOn : 24-05-2019
@ModifiedBy : Ganesh
@Description : Display respective Fieldname,Label and Datatype of an Object
*/
public with sharing class RT_ObjectsMetadataController {
    public List<FieldWrapper> ListofWrapper{get;set;}
    
    public RT_ObjectsMetadataController()
    {
        ListofWrapper = new List<FieldWrapper>();   
    }
    
    @AuraEnabled
    public static List<FieldWrapper> FetchMetaData(String ObjectSC) { 
        List<FieldWrapper> ListofWrapper = new List<FieldWrapper>();
        Map <String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(ObjectSC).getDescribe().fields.getMap();
        for(Schema.SObjectField sfield : fieldMap.Values())
        {
            schema.describefieldresult dfield = sfield.getDescribe();
            FieldWrapper wmp = new FieldWrapper();
            System.debug('>>>1>>>>>'+wmp.Fieldname);
            wmp.Fieldname = dfield.getname ();
            System.debug('>>>>3>>>>'+wmp.Fieldname);
            wmp.Fieldlabel  = dfield.getLabel();
            System.debug('>>>>3>>>>'+wmp.Fielddatatype);
            wmp.Fielddatatype = String.valueOf(dfield.getType());
            
            ListofWrapper.add(wmp);
        }    
        return ListofWrapper;
    }   
    // Wrapper Class Construction
    public class FieldWrapper{
        @AuraEnabled
        public String Fieldname;
        @AuraEnabled
        public String Fieldlabel;
        @AuraEnabled 
        public String Fielddatatype;
    }
}