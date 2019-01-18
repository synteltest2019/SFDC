@isTest(SeeAllData = true )
public class TestEncryptField { 
    static testmethod void AccountEncrTest(){
       test.startTest();  
             
        List<account> accounts = new List<account>();
              
        for (Integer i=0;i<200;i++) {

            Account a = new Account();
                a.Name = 'Test Account'+i;
                //a.Test_Field_1__c = 'Field 1';
                //a.Test_Field_2__c = 'Field 2';
                //a.Test_Field_3__c = 'Field 3';
            
            accounts.add(a);
        }

        insert accounts;
       
     List<account> updateaccounts =  [select id from Account where id in :accounts];
  for(Account acc : updateaccounts){
      acc.Name = 'Test Account';
      //acc.Test_Field_1__c = 'Field 1';
    }
     
      update updateaccounts;
      
      test.StopTest();
    }
}