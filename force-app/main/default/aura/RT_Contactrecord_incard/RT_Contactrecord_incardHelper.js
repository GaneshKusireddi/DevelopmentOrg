({
    fetchcontacts : function(component,event,helper) {
        var action1 = component.get("c.getContacts");
        console.log('action>>>>',component.get("c.getContacts"))
        action1.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                component.set("v.Contactlist", response.getReturnValue());
                console.log('>>>Contactlist>>>',component.get("v.Contactlist"));
            } 
        });
        $A.enqueueAction(action1); 
    },
    
    editRecord : function(component, event, recordId) {
        var editRecordEvent = $A.get("e.force:editRecord");
        console.log('editRecordEvent>>>editRecordEvent>',recordId) 
        editRecordEvent.setParams({ "recordId": recordId });
        editRecordEvent.fire(); 
       // $A.get('e.force:refreshView').fire();
    }, 
    
    searchHelper : function(component,event,getInputkeyWord) {
        // call the apex class method 
        var action = component.get("c.fetchUsers");
        // set param to method  
        action.setParams({
            'searchKeyWord': getInputkeyWord,
            'ObjectName' : component.get("v.objectAPIName")
        });
        // set a callBack    
        action.setCallback(this, function(response) {
            $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords", storeResponse);
            }
            
        });
        // enqueue the Action  
        $A.enqueueAction(action);
        
    },
})