({
    onBookselected : function(component, event, helper) {
        var bookselected=event.getParam("book")
        component.set("v.book",bookselected);	
        console.log('@@book.volumeInfo.readingModes.averageRating---->'+bookselected.volumeInfo);
        console.log('@@book.volumeInfo.readingModes.averageRating--->'+bookselected.volumeInfo.averageRating);
    }
})