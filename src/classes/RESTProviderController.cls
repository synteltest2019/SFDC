@RestResource(urlMapping='/FieldProvider/*')
global with sharing class RESTProviderController {

    @HttpPost
    global static String createNewCase(String companyName, String caseType) {
    
    
        return 'abc';
    
    
    }


}