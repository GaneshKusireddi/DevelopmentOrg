global class RT_UpdateprojectstatusSchedule1 implements schedulable
{
    global void execute(SchedulableContext sc)
    {
        RT_Updateprojectstatus ups = new RT_Updateprojectstatus();
      database.executebatch(ups);
    }
}  
    
    
    
/*    
    
RT_Updateprojectstatus upss = new RT_Updateprojectstatus();
String CRON_EXP = '0 1 * * * ? *';      
System.schedule('Every 1 min', CRON_EXP, upss);

}*/