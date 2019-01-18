public with sharing class AccountController {


    public list<Account> getAccountlist(){
    
        AccountControllerExt ctrl=new AccountControllerExt();
        return ctrl.getAccounts();
        //return [Select id, Name from account];
		//test
		//test123
    }
    
    
    public list<accountWrapper> getAccountlist1(){
        
        List<AccountWrapper> wraps=new List<AccountWrapper>();
        for(Account act:[Select id, Name from account]){
        
            wraps.add(new AccountWrapper(act.id,act.Name));
        }
        return wraps;
    
    }
        
    public with sharing class accountWrapper{
    
        public string id{get;set;}
        public string name{get;set;}
        public accountWrapper(string tId,string tName){
            this.id=tid;
            this.name=tName;
        }
    
    }

}