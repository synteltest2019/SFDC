public class LicenseAvail{

public List<String> ReturnAccessToken (String clientId, String clientSecret, String username, String password )
   {
      List<String> resp = new List<String>();
      String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setBody(reqbody);
      req.setMethod('POST');
      req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
      HttpResponse res = h.send(req);
      system.debug(res.getbody());
      deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
      resp.add(resp1.access_token);
      resp.add(resp1.instance_url);
      return resp;
   }

public void sendLicenses()
{
    String clientId = '3MVG9A2kN3Bn17htNfP.U9APJTHjKYSLZadOD2Rk.kB7ktoUhJB3WTgYrvNdmVzFho_.CMk_PT_uZDpYpl21Q';
    String clientSecret = '3248087447704737504';
    String username = 'nimdilip_mahatani@syntelinc.com@14demo.com';
    String password = '2017@apr';
    List<String> accessTokenURL = ReturnAccessToken(clientId, clientSecret, username, password);
    String accessToken=accessTokenURL[0];
    String accessURL=accessTokenURL[1];
    
    if(accessToken != null){
        Http http = new Http();
        HttpRequest req1 = new HttpRequest();
        req1.setHeader('Authorization','Bearer ' + accessToken);
        req1.setMethod('POST');
        req1.setHeader('Content-Type', 'application/json');

        req1.setEndpoint(accessURL+'/services/apexrest/LicenseUtilization');
        String strbody =JSON.serialize(GetLicenses());
        system.debug( strbody );
        
        req1.setBody(strbody );
        HttpResponse res1 = http.send(req1);
        system.debug(res1);
        system.debug(res1.getBody());
        
    }
}
   
public AllLicense GetLicenses(){
        Organization orgDetails =[select Id, Name from Organization limit 1];
        Id orgId = orgDetails.Id;
        String orgName = orgDetails.Name;
        AllLicense allLic = new AllLicense();
        List<License> lstLic = new List<License>();
        PageReference pr=new PageReference('/100?rlid=RelatedUserLicenseList&id='+orgId);
        //called screenscraping: get the data from the page
        String rawData=pr.getContent().toString();
        List<String> lstPageContent = rawData.split('\n');
        List<String> lstValue = new List<String>();
        for(Integer j=0;j<lstPageContent.size();j++)
        {
            String s = lstPageContent[j];
            if(s.contains('<tr class=" dataRow even') || s.contains('<tr class=" dataRow odd'))
            {
                lstValue.add(s);
            }
            
        }
        for(String s:lstValue)
        {
            License l = new License();
            l.OrgName = orgName;
            l.OrgID = orgId;
            l.LicenseType = 'User Licenses';
            l.Name = s.substringafter('<th scope="row" class=" dataCell  ">').substringbefore('</th>');
            l.Status = s.substringafter('<td class=" dataCell  ">').substringbefore('</td>');
            String tl = s.substringafter('<td class=" dataCell  numericalColumn">').substringbefore('</td>');
            l.TotalLicenses= Integer.Valueof(tl.remove(','));
            l.UsedLicenses = Integer.Valueof(s.substringafter('<td class=" dataCell  numericalColumn">'+tl+'</td><td class=" dataCell  numericalColumn">').substringbefore('</td>').remove(','));
            l.AvailableLicenses = Integer.Valueof(s.substringafterLast('<td class=" dataCell  numericalColumn">').substringbefore('</td>').remove(','));
            lstLic.add(l);
        }

        pr=new PageReference('/'+orgId);
        //called screenscraping: get the data from the page
        String rawData2 = pr.getContent().toString();
        rawData = rawData2.substringafter('>Permission Set Licenses<').substringbefore('-- End RelatedListElement --');
        lstPageContent = rawData.split('\n');
        lstValue = new List<String>();
        for(Integer j=0;j<lstPageContent.size();j++)
        {
            String s = lstPageContent[j];
            if(s.contains('<tr class=" dataRow even') || s.contains('<tr class=" dataRow odd'))
            {
                lstValue.add(s);
            }
            
        }
        for(String s:lstValue)
        {
            License l = new License();
            l.OrgName = orgName;
            l.OrgID = orgId;
            l.LicenseType = 'Permission Set Licenses';
            l.Name = s.substringafter('<th scope="row" class=" dataCell  ">').substringbefore('</th>');
            l.Status = s.substringafter('<td class=" dataCell  ">').substringbefore('</td>');
            String tl = s.substringafter('<td class=" dataCell  numericalColumn">').substringbefore('</td>');
            l.TotalLicenses= Integer.Valueof(tl.remove(','));
            l.UsedLicenses = Integer.Valueof(s.substringafter('<td class=" dataCell  numericalColumn">'+tl+'</td><td class=" dataCell  numericalColumn">').substringbefore('</td>').remove(','));
            l.AvailableLicenses = Integer.Valueof(s.substringafterLast('<td class=" dataCell  numericalColumn">').substringbefore('</td>').remove(','));
            lstLic.add(l);
        }

        rawData = rawData2.substringafter('>Feature Licenses<').substringbefore('-- End RelatedListElement --');
        lstPageContent = rawData.split('\n');
        lstValue = new List<String>();
        for(Integer j=0;j<lstPageContent.size();j++)
        {
            String s = lstPageContent[j];
            if(s.contains('<tr class=" dataRow even') || s.contains('<tr class=" dataRow odd'))
            {
                lstValue.add(s);
            }
            
        }
        for(String s:lstValue)
        {
            License l = new License();
            l.OrgName = orgName;
            l.OrgID = orgId;
            l.LicenseType = 'Feature Licenses';
            l.Name = s.substringafter('<th scope="row" class=" dataCell  ">').substringbefore('</th>');
            l.Status = s.substringafter('<td class=" dataCell  ">').substringbefore('</td>');
            String tl = s.substringafter('<td class=" dataCell  numericalColumn">').substringbefore('</td>');
            l.TotalLicenses= Integer.Valueof(tl.remove(','));
            l.UsedLicenses = Integer.Valueof(s.substringafter('<td class=" dataCell  numericalColumn">'+tl+'</td><td class=" dataCell  numericalColumn">').substringbefore('</td>').remove(','));
            l.AvailableLicenses = Integer.Valueof(s.substringafterLast('<td class=" dataCell  numericalColumn">').substringbefore('</td>').remove(','));
            lstLic.add(l);
        }
        
        allLic.Licenses = lstLic;
        system.debug(allLic);
        return allLic; 
}  

public class License{
    String OrgName;
    String OrgID;
    String LicenseType;
    String Name;
    String Status;
    Decimal TotalLicenses;
    Decimal UsedLicenses;
    Decimal AvailableLicenses;
}

public class AllLicense{
    List<License> Licenses;
}

private class deserializeResponse
   {
      public String id;
      public String access_token;
      public String instance_url;
   }   
}