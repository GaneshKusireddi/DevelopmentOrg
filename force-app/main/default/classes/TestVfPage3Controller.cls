public class TestVfPage3Controller {
    
    private integer count=1;   //to track the function calling
    private integer counter=0;   //to keep track of offset
    private integer list_size=5; //to set the page size to show the rows/records
    public integer total_size; //used to show user the total size of the list   
    Public List<Employee__c> lstemp {get;set;}
    public integer getcounter()
    {
        return counter;
    }
    
     public Employee__c e {
        get;
        set;
      }
          
    public  TestVfPage3Controller(){
        lstemp= new List<Employee__c>();
        lstemp = [SELECT ID, Name, Phone__c, Email__c, Country__c, City__c FROM Employee__c ORDER BY Name limit 5];
        total_size=[select count() from Employee__c];    //set the total size in the constructor
        
        e=new Employee__c();
      }
    
// Insertion
      public PageReference saveDetails() {
        insert e;
           update lstemp;
        return null;
    }  
 
// INDEXING--
/* private void myMethod() {
  Integer counter1 = 0;       
 for (Employee__c item : [Select Name from Employee__c]) {
            counter1 = counter1 + 1;
            // add the wrapper to the collection
          lstemp1.add(new DataTableWrapper(item, counter1));
        }
 }
    
    Public List<DataTableWrapper> lstemp1 {get;}
    class DataTableWrapper {
        
        public Integer counter1 { get; set; }
        public Employee__c item { get; set;}
        
        public DataTableWrapper(Employee__c item, Integer counter1) {
            this.item = item;
            this.counter1 = counter1;
        }
        
    }  */   
       
// SORTING        
   private String sortDirection = 'ASC';
   private String sortExp = 'name';
    
   public String sortExpression
   {
     get
     {
        return sortExp;
     }
     set
     {
       //if the column is clicked on then switch between Ascending and Descending modes
       if (value == sortExp)
         sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
       else
         sortDirection = 'ASC';
       sortExp = value;
     }
   }

 public String getSortDirection()
 {
    //if not column is selected 
    if (sortExpression == null || sortExpression == '')
      return 'ASC';
    else
     return sortDirection;
 }

 public void setSortDirection(String value)
 {  
   sortDirection = value;
 }

 public PageReference ViewData() {
       //build the full sort expression
       string sortFullExp = sortExpression  + ' ' + sortDirection;
      
       //query the database based on the sort expression
       lstemp = Database.query('Select id, Name, Phone__c, Email__c,Country__c,City__c from Employee__c order by ' + sortFullExp + ' limit 5');
       return null;
   }        
        
// pagination
    public PageReference Beginning() {  //when the user clicked the beginning button
        counter=0;
        lstemp = [SELECT ID, Name, Phone__c, Email__c, Country__c, City__c FROM Employee__c ORDER BY Name limit 5];
        return null;
    }
    
    public PageReference Previous() { //user clicked the previous button
        counter -= list_size;
        if(count==1){
            lstemp = [SELECT ID, Name, Phone__c, Email__c, Country__c, City__c FROM Employee__c ORDER BY Name limit 5 offset:counter];
            count++;
        }
        else 
            lstemp = [SELECT ID, Name, Phone__c, Email__c, Country__c, City__c FROM Employee__c ORDER BY Name limit 5 offset:counter];
        return null;
    }
    
    public PageReference Next() {    //user clicked the Next button
        counter += list_size;
        lstemp = [SELECT ID, Name, Phone__c, Email__c, Country__c, City__c FROM Employee__c ORDER BY Name limit 5 offset:counter];
        return null;
        
    }
    
    public PageReference End() {      //user clicked the End button
        counter = total_size - math.mod(total_size, list_size);
        lstemp = [SELECT ID, Name, Phone__c, Email__c, Country__c, City__c FROM Employee__c ORDER BY Name limit 5 offset:counter];
        return null;
    }
    
    public Boolean getDisabledPrevious() {           //this will disable the previous and beginning buttons
        if(counter>0)
            return false;
        else 
            return true;
        
    }
    public Boolean getDisabledNext() {            //this will disable the next and end buttons
        if (counter + list_size < total_size) 
            return false; 
        else 
            return true;
        
    }
    public Integer getTotal_size() {
        return total_size;
    }   
    
// Save and edit
    public Id editId {get; set;}
    public void saveRecord(){
        update lstemp;
        editId = null;
    }
    
 // searching 
    String searchText;
    public String getSearchText() {
        return searchText;
    }
    public void setSearchText(String s) {
        searchText = s;
            
    }
    public List<Employee__c> getlstemp() {
        return lstemp;
    }
    public PageReference doSearch() {
        lstemp= (List<Employee__c>)[FIND :searchText RETURNING Employee__c(Name, Phone__c,Email__c,Country__c,
                                                                           City__c)][0];
        
        //  PageReference redirectSuccess = new ApexPages.StandardSetController(lstemp).view();
        return null;
    }    
}