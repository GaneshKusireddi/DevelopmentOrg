({
   selectRecord : function(component, event, helper){
       console.log('selectRecord');
    // get the selected record from list  
      var getSelectRecord = component.get("v.oRecord");
        console.log('selectRecord',getSelectRecord);
    // call the event   
      var compEvent = component.getEvent("oSelectedRecordEvent");
    // set the Selected sObject Record to the event attribute.  
         compEvent.setParams({"accountByEvent" : getSelectRecord });  
    // fire the event  
         compEvent.fire();
    },
})