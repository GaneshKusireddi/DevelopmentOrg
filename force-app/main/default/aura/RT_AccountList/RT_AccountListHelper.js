({
    // Fetch the accounts from the Apex controller
    getAccountList: function(component) {
        var action = component.get('c.getAccount');
        // Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.Account', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})