public without sharing class  AccountControllerExt{


    public list<Account> getAccounts(){
    
        return [Select Id,Name from ACcount];
    
    }


}