trigger RT_AccountTriggerPractice on Account (before insert,before update)
{
/* 
         Set<string> name= new Set<string>();
   
      
        
         for(account acc : Trigger.new)
         {
           name.add(acc.name);
         }

       
       List<account> duplicateaccountList = [Select name From account where name = :name];

       Set<string > duplicateaccIds= new Set<string >();

       for(account dup: duplicateaccountList )
       {
         duplicateaccIds.add(dup.name);
       }

       for(account a : Trigger.new)
       {
            if(a.name!=null)
            {
               if(duplicateaccIds.contains(a.name))
               {
                 a.addError('Record already exist with same Name');
               }
            
            }
       }*/
}