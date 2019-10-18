({
	saveItas : function(component) {
        var enable = component.get('v.childlstemployee');
         console.log('...........',enable);
       var action = component.get('c.updateEmployee');
  
        action.setParams({"upemps" : enable});
        action.setCallback(this, function(response) {
            var state = response.getState();            
        });
        $A.enqueueAction(action);
    }
 })