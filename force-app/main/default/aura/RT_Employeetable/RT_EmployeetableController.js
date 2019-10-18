({
	myAction : function(component, event, helper) {
        helper.getEmps(component, event, helper);
    }
    
})
         





















/*
({
	myAction : function(component, event, helper) {
	     component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text' ,editable: true},
            {label: 'Phone', fieldName: 'Phone__c', type: 'phone' ,editable: true},
            {label: 'Email', fieldName: 'Email__c', type: 'Email' ,editable: true},
            {label: 'Country', fieldName: 'Country__c', type: 'text' ,editable: true},
        ]);
		  helper.fetchlstEmployees(component);
	},
	
	 handleSaveEdition: function (component, event, helper) {
        var draftValues = event.getParam('draftValues');
        console.log(draftValues);
        var action = component.get("c.updateEmployee");
        action.setParams({"emp" : draftValues});
        action.setCallback(this, function(response) {
            var state = response.getState();
            $A.get('e.force:refreshView').fire();
            
        });
        $A.enqueueAction(action);
        
    }
})
*/