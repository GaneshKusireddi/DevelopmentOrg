@isTest
public class RT_ReportsFilteTestClass {
    
    @isTest(SeeAllData='true')
    public static void testReportWithTestData() {
        List<Account> acc = [SELECT ID FROM Account];
        System.debug('>>>acc>'+acc);
        RT_ReportsFilter.doPost('AccountAndContactReport');
    }
}    
    /*  @testSetup static void setup() {

List <Report> reportList = [SELECT Id,DeveloperName FROM Report where
DeveloperName = 'AccountAndContactReport'];
String DevName = (String)reportList.get(0).get('DeveloperName');
RT_ReportsFilter.doPost('AccountAndContactReport');

}*/


/*
@isTest(SeeAllData='true')
public static void testReportWithTestData() {

List<Account> lstAcc = new List<Account>{
new Account(Name='test1'),
new Account(Name='test2'),
new Account(Name='test3'),
new Account(Name='test4')};
Insert lstAcc;
List <Report> reportList = [SELECT Id,DeveloperName FROM Report where
DeveloperName = 'AccountAndContactReport'];
String DevName = (String)reportList.get(0).get('DeveloperName');
RT_ReportsFilter.doPost('AccountAndContactReport');

}
}     
/*    
// Create an Opportunity object.
Opportunity opp = new Opportunity(Name='ApexTestOpp', StageName='stage',
Probability = 95, CloseDate=system.today());
insert opp;

Reports.ReportMetadata reportMetadata =
Reports.ReportManager.describeReport(reportId).getReportMetadata();

// Add a filter.
List<Reports.ReportFilter> filters = new List<Reports.ReportFilter>(); 
Reports.ReportFilter newFilter = new Reports.ReportFilter();
newFilter.setColumn('OPPORTUNITY_NAME');
newFilter.setOperator('equals');
newFilter.setValue('ApexTestOpp');
filters.add(newFilter);
reportMetadata.setReportFilters(filters);

Test.startTest();

Reports.ReportInstance instanceObj =
Reports.ReportManager.runAsyncReport(reportId,reportMetadata,false);
String instanceId = instanceObj.getId();

// Report instance is not available yet.
Test.stopTest();
// After the stopTest method, the report has finished executing
// and the instance is available.

instanceObj = Reports.ReportManager.getReportInstance(instanceId);
System.assertEquals(instanceObj.getStatus(),'Success');
Reports.ReportResults result = instanceObj.getReportResults();
Reports.ReportFact grandTotal = (Reports.ReportFact)result.getFactMap().get('T!T');
System.assertEquals(1,(Decimal)grandTotal.getAggregates().get(1).getValue());
}

@isTest(SeeAllData='true')
public static void testSyncReportWithTestData() {

// Create an Opportunity Object.
Opportunity opp = new Opportunity(Name='ApexTestOpp', StageName='stage',
Probability = 95, CloseDate=system.today());
insert opp;

List <Report> reportList = [SELECT Id,DeveloperName FROM Report where
DeveloperName = 'Closed_Sales_This_Quarter'];
String reportId = (String)reportList.get(0).get('Id');

Reports.ReportMetadata reportMetadata =
Reports.ReportManager.describeReport(reportId).getReportMetadata();

// Add a filter.
List<Reports.ReportFilter> filters = new List<Reports.ReportFilter>(); 
Reports.ReportFilter newFilter = new Reports.ReportFilter();
newFilter.setColumn('OPPORTUNITY_NAME');
newFilter.setOperator('equals');
newFilter.setValue('ApexTestOpp');
filters.add(newFilter);
reportMetadata.setReportFilters(filters);

Reports.ReportResults result =
Reports.ReportManager.runReport(reportId,reportMetadata,false); 
Reports.ReportFact grandTotal = (Reports.ReportFact)result.getFactMap().get('T!T');
System.assertEquals(1,(Decimal)grandTotal.getAggregates().get(1).getValue());
}
}*/