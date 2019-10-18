({
    addAccountRecord: function(component, event) {
        //get the account List from component  
        var accountList = component.get("v.accountList");
        //Add New Account Record
        accountList.push({
            'sobjectType': 'Account',
            'Name': '',
            'AccountNumber': '',
            'Phone': ''
        });
        component.set("v.accountList", accountList);
    },
     
    validateAccountList: function(component, event) {
        //Validate all account records
        var isValid = true;
        var accountList = component.get("v.accountList");
        for (var i = 0; i < accountList.length; i++) {
            if (accountList[i].Name == '') {
                isValid = false;
                alert('Account Name cannot be blank on row number ' + (i + 1));
            }
        }
        return isValid;
    },
      
})