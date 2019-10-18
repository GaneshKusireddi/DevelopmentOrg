({
    insertexpensevalues: function(component, event, helper) 
    {
        console.log('Id>>>>> ',component.get("v.selectedRecord.Id"));
        console.log('>>newExpense>',component.get("v.newExpense"));
        
        var action = component.get("c.createExpenses");
        action.setParams({
            newExpenses:component.get("v.newExpense"),
            recID: component.get("v.selectedRecord.Id")
        }); 
        
         action.setCallback(this, function(response) {
            var state = response.getState();
             console.log('state>>>>',state);
           if (state === "SUCCESS") {
                alert("title"== "Success!",
                      "message"== "Student record has been updated successfully.");
            }
            else if (state === "INCOMPLETE") {
               alert("title"== "Notsuccess!",
                      "message"== "Student record has not been updated successfully.");
            }
          /*  else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }  */
        });
        $A.enqueueAction(action);
    },
    
   	searchHelper : function(component,event,getInputkeyWord) {
	  // call the apex class method 
     var action = component.get("c.fetchAccount");
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