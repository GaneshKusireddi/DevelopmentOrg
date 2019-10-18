({
    myAction : function(component, event, helper) {
        var action = component.get("c.FetchMetaData");
         console.log('<<FetchMetaData>>',action);
        action.setParams ({ObjectSC:component.get('v.objectlst')})
        console.log('<<component.get(v.objectlst)>>',component.get('v.objectlst'));
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('state>>>',state);
            if(state==="SUCCESS"){
                console.log('>>>>>>>>>>');
                console.log('<<response.getReturnValue()>>',response.getReturnValue());
                component.set("v.fieldvalues",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})