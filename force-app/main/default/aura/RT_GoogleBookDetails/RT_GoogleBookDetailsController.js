({
    getBooks : function(component, event, helper) {
        var action = component.get("c.getBookDetails");
         console.log('searchkey----->',component.get("v.searchkey"));
        action.setParams({
            "SearchKey":component.get("v.searchkey")
        });
       
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                console.log('search results--->'+response.getReturnValue());
                component.set("v.books",JSON.parse(response.getReturnValue()).items);
            }
            else {
                console.log('@@@@inside  Faliure');
                console.log("Failed with state1: " );
            }
        });
        
        $A.enqueueAction(action);
    },
    clear:function(component,event,helper){
          component.set("v.books",empty());
    }
})