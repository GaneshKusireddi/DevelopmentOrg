({
    onBookclick : function(component, event, helper) {
        component.set("v.selected",true);
        var appEvent = $A.get("e.c:RT_GoogleBookSelected");
        appEvent.setParams({
            "book": component.get("v.book")
        });
        appEvent.fire();
    }
})