({
    insertAccountvalues: function(component, event, helper) 
    {
        console.log('Id>>>>> ',component.get("v.selectedRecord.Id"));
        console.log('>>newAccount>',component.get("v.newAccount"));
        
        var action = component.get("c.createAccount");
        action.setParams({
            objAccount:component.get("v.newAccount"),
            recID: component.get("v.selectedRecord.Id")
        }); 
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state>>>>',state);
            if (state === "SUCCESS") {
                console.log('state11>>>>',state);
                $A.get("e.force:closeQuickAction").fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been updated successfully.",
                    "Type":"success"
                });
                toastEvent.fire();
            }
            else if (state === "ERROR") {
                var toastEvent = $A.get("e.force:showToast");
                $A.get("e.force:closeQuickAction").fire();
                toastEvent.setParams({
                    "title": "Error!",
                    "message": "error occured.",
                    "Type":"error"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
    
    searchHelper : function(component,event,getInputkeyWord) {
        // call the apex class method 
        var action = component.get("c.fetchAccount");
        // set param to method  
        action.setParams({'searchKeyWord': getInputkeyWord,
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