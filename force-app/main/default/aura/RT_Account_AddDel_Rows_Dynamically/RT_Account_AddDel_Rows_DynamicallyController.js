({
    onload:function(component, event, helper) {
        helper.addAccountRecord(component, event);
    },
    
    addRow: function(component, event, helper) {
        helper.addAccountRecord(component, event);
    },
     
    removeRow: function(component, event, helper) {
      
        //Get the account list
        var accountList = component.get("v.accountList");
        //Get the target object
        var selectedItem = event.currentTarget;
        //Get the selected item index
        //var index = selectedItem.dataset.record;
        var indextoberemoved = event.currentTarget.dataset.id;
        accountList.splice(indextoberemoved, 1);
        component.set("v.accountList", accountList);
    },
     
    save: function(component, event, helper) {
        if (helper.validateAccountList(component, event)) {
            //Call Apex class and pass account list parameters
        var action = component.get("c.saveAccounts");
        action.setParams({
            "accList": component.get("v.accountList")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accountList", []);
                alert('Account records saved successfully');
                 helper.addAccountRecord(component, event);
            }
        }); 
        $A.enqueueAction(action);
    }
        }
})