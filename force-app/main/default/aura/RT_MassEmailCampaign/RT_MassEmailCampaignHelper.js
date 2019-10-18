({
    searchHelper : function(component,event,getInputkeyWord) {
        // call the apex class method 
        var action = component.get("c.fetchLookUpValues");
        
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
                console.log('storeResponse----->',storeResponse);
                // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords", storeResponse);
                console.log('listOfSearchRecords----->', component.get("v.listOfSearchRecords"));
            }
            
        });
        // enqueue the Action  
        $A.enqueueAction(action);
        
    },
    
    searchHelperCont : function(component,event,getInputkeyWord) {
        // call the apex class method 
        var action = component.get("c.cfetchLookUpValues");
        // set param to method  
        action.setParams({
            'ContactSearchKeyWord': getInputkeyWord,
            'ObjectName' : component.get("v.objectAPINameContact"),
            'ExcludeitemsList' : component.get("v.lstSelectedRecords")
        });
        // set a callBack    
        action.setCallback(this, function(response) {
            $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                // if storeResponse size is equal 0 ,display No Records Found... message on screen.                }
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Records Found...');
                } else {
                    component.set("v.Message", '');
                    // set searchResult list with return value from server.
                }
                component.set("v.listOfSearchRecords", storeResponse); 
            }
        });
        // enqueue the Action  
        $A.enqueueAction(action);
    },
})