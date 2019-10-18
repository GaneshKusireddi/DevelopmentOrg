({ 
    lstUserRecords:function(component, event, helper) {
        console.log('>>>lstUserRecords>>>');
        var action1 = component.get("c.getUserRecords");
        action1.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS"){
                component.set("v.UserTeamList", a.getReturnValue());
                console.log('>>>111>>>',component.get("v.UserTeamList"));
            } 
        });
        $A.enqueueAction(action1);
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
                // if storeResponse size is equal 0 ,display No Result Found... message on screen.
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", 'Search Result...');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords", storeResponse);
            }
        });
        // enqueue the Action  
        $A.enqueueAction(action);
        
    }
})