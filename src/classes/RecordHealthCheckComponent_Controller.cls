public class RecordHealthCheckComponent_Controller{
    
    Public string urlID ;
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public List<Pair> lstfieldname{get;set;}
    public List <Pair> fields {get{return lstfieldname;} set{lstfieldname =value;}}
    private Map <String, Schema.SObjectField> fieldMap {get;set;}
    public String reqFields{get;set;}
    public List<String> traverse{get;set;}
    Public List<sObject> obj{get;set;}
    Public double totalFields{get;set;}
    Public double nullFields{get;set;}
    Public String imageName{get; private set;}
    Public String ObjName{get; private set;}
    Public boolean Flag{get; set;}
    
    public RecordHealthCheckComponent_Controller() {
        imagename = 'blank.jpg';
        Flag=true;
    }
    
    public String geturlID(){
        return urlId;
        }   
    
    
     public void seturlID (String s){
        if (s!=null && flag){
          urlID = s;
          Flag = False;
          findObj();
        }
        }
     
    Public void findObj()
    {
    if(urlId != null)
    { 
        String myIdPrefix = String.valueOf(urlID).substring(0,3); //get just the prefix
        for(Schema.SObjectType stype : schemaMap.values())
        {
            Schema.DescribeSObjectResult r = stype.getDescribe();
            String prefix = r.getKeyPrefix();
            if(prefix!=null && prefix.equals(myIdPrefix))
            {
                ObjName=r.getName();
                break;
            }
        }
        findFields();
    }    
    }
    
    
    public void findFields() {
    
        SObjectType objType = Schema.getGlobalDescribe().get(ObjName);
        fieldMap = objType.getDescribe().fields.getMap();
        lstfieldname= new List<Pair>();
        traverse= new List<String> ();
        
        
        for(Schema.SObjectField sfield : fieldMap.Values()) {
            schema.describefieldresult dfield = sfield.getDescribe();
            Pair field = new Pair();
            field.key = dfield.getname();
            field.val = dfield.getType () + '';
            
            lstfieldname.add(field);
            
            system.debug('$$$$$$$$$$$$$$$$$$$'+ field.key +'>>>>>>>>>>>>'+ field.val);
            
            if(field.val.equalsignorecase('TEXTAREA') || field.val.equalsignorecase('phone') || field.val.equalsignorecase('STRING') || field.val.equalsignorecase('DOUBLE')|| 
            field.val.equalsignorecase('ADDRESS') || field.val.equalsignorecase('DATE') || field.val.equalsignorecase('DATETIME') || field.val.equalsignorecase('CURRENCY') ||
            field.val.equalsignorecase('INTEGER')) {
                if(reqFields== null || reqFields== '') {
                    reqFields= field.key;
                }else {
                    reqFields= reqFields+ ', ' + field.key;
                }
                    traverse.add(field.key);
            }
        }
        fetchData();
    }
    
    public void fetchData() {
        if(urlid != null) {
            string query = 'select ' + reqFields + ' from '+ObjName+' where id = \''+urlid+'\'';
            obj= Database.query(query);
            checkFields();
        }
    }   
    
    public void checkFields() {
        nullFields = 0;
        for(sobject sobj : obj)
            for(string t : traverse)
            {
                if(sobj.get(t) == null)
                {
                    nullFields++;
                }
            }
        totalFields=traverse.size();
        showProgressImage();
    }
    
    public void showProgressImage()
    {
        double chk = ((totalFields-nullFields)/totalFields)*100 ;
        if(chk > 60 )
        {
            System.debug('>>>>>>>>>>>>Green');
            imageName = 'Green.jpg';
        }
        else if (chk > 50 && chk <=60)
        {
            imageName = 'Orange.jpg';
        }
        else if (chk <=50)
        {
            imageName = 'red.jpg';
        }
    } 
    
    public class Pair
    {
        public String key {get; set;}
        public String val {get; set;}
    }    
    
}