({
    getEmps: function(component, event, helper) {
        var action=component.get("c.getEmployees");
        action.setCallback(this,function(data){
           
            component.set('v.lstEmployee',data.getReturnValue());
             console.log('>>>>',data.getReturnValue());
        });
        $A.enqueueAction(action);
       console.log('>>>>',component.get("v.lstEmployee"));
    }    
})