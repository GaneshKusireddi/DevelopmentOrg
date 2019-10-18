({
    onload: function (component,event,helper){
        
        var action = component.get("c.getUser");
        console.log('action>>>>',component.get("c.getUser"))
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS"){
                component.set("v.CurrentUser", a.getReturnValue());
                console.log('>>>111>>>',component.get("v.CurrentUser"));
            } 
        });
        $A.enqueueAction(action);
        helper.fetchcontacts(component,event,helper);
    },
    
    handleSelect: function(component, event, helper) {
        
        var  tempid = event.getSource().get("v.class");
        console.log('tempid>>>>',tempid)
        component.set("v.CurrentRecId",tempid);
        console.log('tempid>123>>>',component.get("v.CurrentRecId"));
        
        var menuValue = event.detail.menuItem.get("v.value");
        
        switch(menuValue) {
            case "Edit": helper.editRecord(component, event,tempid);
                location.reload();
                break;
                
            case "Delete": component.set("v.isModalOpen", true);
                break;
                
            case "Change Owner":  component.set("v.isChangeOwnerModalOpen", true); 
                break;
        }
    },
    
    doDelete: function(component, event, helper) {
        var action = component.get("c.deleteContactById");
        console.log('tempid>12345>>>',component.get("v.CurrentRecId"));
        action.setParams({"conid":component.get("v.CurrentRecId")});
        action.setCallback(this, function(response) {
            helper.fetchcontacts(component,event,helper);
            component.set("v.isModalOpen", false);
        });
        $A.enqueueAction(action);
    },
    
    closeModel:  function (component,event,helper){
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
        component.set("v.isChangeOwnerModalOpen", false);
    },   
    
    //change owner with check box
    handleCheck : function(component, event, helper) {
        var isChecked = component.find("emailCheckbox").get("v.checked");
        component.set("v.holdCheckBoxValue", isChecked);
        console.log('>>is checked>>',isChecked);
    },
    
    doSubmit: function(component, event, helper){
        var getSelectedUserId = component.get("v.selectedRecord.Id");
        var currentContactId = component.get("v.CurrentRecId");
        var getCheckBoxValue = component.get("v.holdCheckBoxValue");
        
        var action = component.get("c.changeContactOwner");
        action.setParams({
            selectedUId: getSelectedUserId,
            Ischecked: getCheckBoxValue,
            contactId: currentContactId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('state>>',state);
            if (state === "SUCCESS") {
                console.log('Successsssss---->>>'); 
                component.set("v.isChangeOwnerModalOpen",false);
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action); 
    },
    //end
    
    onfocus : function (component,event,helper){
        console.log('onfocus');
        $A.util.addClass(component.find("mySpinner"), "slds-show");
        var forOpen = component.find("searchRes");
        $A.util.addClass(forOpen, 'slds-is-open');
        $A.util.removeClass(forOpen, 'slds-is-close');
        // Get Default 5 Records order by createdDate DESC  
        var getInputkeyWord = '';
        helper.searchHelper(component,event,getInputkeyWord);
    },
    onblur : function(component,event,helper){       
        component.set("v.listOfSearchRecords", null );
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
    },
    keyPressController : function(component, event, helper) {
        console.log('keyPressController');
        // get the search Input keyword   
        var getInputkeyWord = component.get("v.SearchKeyWord");
        // check if getInputKeyWord size id more then 0 then open the lookup result List and 
        // call the helper 
        // else close the lookup result List part.   
        if( getInputkeyWord.length > 0 ){
            var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component,event,getInputkeyWord);
        }
        else{  
            component.set("v.listOfSearchRecords", null ); 
            var forclose = component.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
        }
    },
    
    // function for clear the Record Selaction 
    clear :function(component,event,heplper){
        var pillTarget = component.find("lookup-pill");
        var lookUpTarget = component.find("lookupField"); 
        
        $A.util.addClass(pillTarget, 'slds-hide');
        $A.util.removeClass(pillTarget, 'slds-show');
        
        $A.util.addClass(lookUpTarget, 'slds-show');
        $A.util.removeClass(lookUpTarget, 'slds-hide');
        
        component.set("v.SearchKeyWord",null);
        component.set("v.listOfSearchRecords", null );
        component.set("v.selectedRecord", {} );   
    },
    
    // This function call when the end User Select any record from the result list.   
    handleComponentEvent : function(component, event, helper) {
        // get the selected Account record from the COMPONETN event 	 
        var selectedAccountGetFromEvent = event.getParam("accountByEvent");
        console.log('selectedAccountGetFromEvent',selectedAccountGetFromEvent)
        component.set("v.selectedRecord" , selectedAccountGetFromEvent); 
        
        var forclose = component.find("lookup-pill");
        $A.util.addClass(forclose, 'slds-show');
        $A.util.removeClass(forclose, 'slds-hide');
        
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
        
        var lookUpTarget = component.find("lookupField");
        $A.util.addClass(lookUpTarget, 'slds-hide');
        $A.util.removeClass(lookUpTarget, 'slds-show');  
        
    },
    
})