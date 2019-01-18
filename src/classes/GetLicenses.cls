@RestResource(urlMapping='/LicenseUtilization/*')

global with sharing class GetLicenses{

@HttpPost
global static void doPost(List<License> Licenses){
    List<License_Usage__c> newLicenses = new List<License_Usage__c>();
    List<License_Usage__c> oldLicenses = new List<License_Usage__c>();
    for(License l:Licenses)
    {
        License_Usage__c lu = new License_Usage__c();
        lu.OrgName__c = l.OrgName;
        lu.OrgID__c = l.OrgID;
        lu.LicenseType__c = l.LicenseType;
        lu.LicenseName__c = l.Name;
        lu.Status__c = l.Status;
        lu.TotalLicenses__c = l.TotalLicenses;
        lu.UsedLicenses__c = l.UsedLicenses;
        lu.AvailableLicenses__c = l.AvailableLicenses;
        newLicenses.add(lu);
    }
    oldLicenses = [select id from License_Usage__c where OrgID__c = :newLicenses[0].OrgID__c];
    delete oldLicenses;
    insert newLicenses;
}


global class License{
    String OrgName;
    String OrgID;
    String LicenseType;
    String Name;
    String Status;
    Decimal TotalLicenses;
    Decimal UsedLicenses;
    Decimal AvailableLicenses;
}

}