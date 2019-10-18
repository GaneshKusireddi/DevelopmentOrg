global class RT_UpdateprojectstatusSchedule {
    
    global void execute(SchedulableContext sc)
    {
        RT_Updateprojectstatus ups = new RT_Updateprojectstatus();
      database.executebatch(ups);
    }
}