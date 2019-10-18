({
	editRecord : function(component, event, helper){
         component.set("v.isEdit",true);
        }, 
      saveIt : function(component, event, helper){
         component.set("v.isEdit",false);
          helper.saveItas(component);
        },    
     closeIt : function(component, event){
         component.set("v.isEdit",false);
         
       
    }    
   
})