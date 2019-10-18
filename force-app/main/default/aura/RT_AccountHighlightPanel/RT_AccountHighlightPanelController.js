({
    doInit : function(component, event, helper) {
        console.log('>>>>>',component.get("v.recordId"));
        var action = component.get("c.getFieldSet");
        action.setParams ({recId:component.get('v.recordId')})
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('state>>>',state);
            if(state==="SUCCESS"){
                console.log('<<response.getReturnValue>>',response.getReturnValue());
                component.set("v.fieldvalues",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);                     
    }
})