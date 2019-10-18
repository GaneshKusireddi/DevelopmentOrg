@RestResource(urlMapping='/Reports/*')
global with sharing class RT_ReportsFilter {
   global class bindLabelWithId{
        String recId;
        String recLabel;
        bindLabelWithId(String recId, String recLabel){
            this.recId =recId;
            this.recLabel= recLabel;
        }
    }
    
    @HttpPost
    global static List<bindLabelWithId> doPost(String DevName){
        System.debug('<<DevName>>'+DevName);
        // Get the report ID
        List <Report> reportList = [SELECT Id,DeveloperName FROM Report where DeveloperName =: DevName];
        
        System.debug('<<reportList>>'+reportList);
        
        String   reportid = (String)reportList.get(0).get('Id');
        
        System.debug('<<reportid>>'+reportid);
        
        // Get the report metadata
        Reports.ReportDescribeResult describe = Reports.ReportManager.describeReport(reportid);
        Reports.ReportMetadata reportMd = describe.getReportMetadata();
        System.debug('<<reportMd>>'+reportMd);
        
        // get standard date filters
        Reports.StandardDateFilter standardDateFilters  = reportMd.getStandardDateFilter();
        standardDateFilters.setColumn('CREATED_DATE');
        standardDateFilters.setDurationValue('THIS_MONTH');
        reportMd.setStandardDateFilter(standardDateFilters);
        
        /*//date filter
Reports.StandardDateFilter standardDateFilters  = reportMd.getStandardDateFilter();
System.debug('>>>>standardDateFilters>>>'+standardDateFilters);
standardDateFilters.StandardDateFilter(CreatesDate, durationValue, startDate, endDate);*/
        
        // Override filter and run report
        List<Reports.ReportFilter> lstOfFilter = new List<Reports.ReportFilter>();        
        System.debug('<<filter>>'+lstOfFilter);
        Reports.ReportFilter newFilter = new Reports.ReportFilter();
        newFilter.setColumn('OWNER_FULL_NAME');
        newFilter.setOperator('equals');
        newFilter.setValue('Ganesh kusireddi');
        lstOfFilter.add(newFilter);
        
        reportMd.setReportFilters(lstOfFilter);
        Reports.ReportResults results = Reports.ReportManager.runReport(reportid, reportMd);
        System.debug('>>>results>>>>'+results);
        
        // Get the first down-grouping in the report
        Reports.Dimension dim = results.getGroupingsDown();
        System.debug('>>>>>dim>>>'+dim);
        
         List<bindLabelWithId> wrapperClassList = new List<bindLabelWithId>();
        for(Reports.GroupingValue val : dim.getGroupings()){
            wrapperClassList.add(new bindLabelWithId((String)val.getValue(),(String)val.getLabel()));
            
            System.debug('Key: ' + val.getKey());
            System.debug('Label: ' + val.getLabel());
            System.debug('Value: ' + val.getValue());
        }
        
        return wrapperClassList;
    }
}