@isTest(SeeAllData=true)
public class TestEncryptController{
      public static testMethod void TestEncryptDecrypt(){
      
      Test.startTest();      
      Test.setCurrentPage(Page.encryption);
      encryptionobj__c settings= encryptionobj__c.getOrgDefaults();
      encrypt_Config__c objEncrConf = new encrypt_Config__c();
      encryptController objEncryptController = new encryptController();
      
      //objEncryptController.seckey = Blob.valueof(settings.key__c);
      objEncryptController.run();
      
      objEncryptController.objectval = 'Account'; 
      objEncryptController.getFieldss();
      objEncryptController.getFieldss2();
      objEncryptController.fieldval = 'name';
      objEncryptController.encrypt();
      objEncryptController.decrypt();
      objEncryptController.testfunction();
      
      Test.stopTest();
  }

}