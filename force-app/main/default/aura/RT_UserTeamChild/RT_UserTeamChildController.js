({
    selectAccount : function(component, event, helper){   
        console.log('<<In Child>>');
        // get the selected Account from list  
        var getSelectAccount = component.get("v.oUser");
        console.log('<<<name>>',getSelectAccount);
        // call the event   
        var compEvent = component.getEvent("oSelectedAccountEvent");
        // set the Selected Account to the event attribute.  
        compEvent.setParams({"accountByEvent" : getSelectAccount });  
        // fire the event  
        compEvent.fire();
    },
})