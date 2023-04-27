public with sharing class oppHomeExtension {

    public String myOpp{get;set;}
    //private ApexPages.StandardSetController controller;
    //List<Opportunity> opp;
    public oppHomeExtension(ApexPages.StandardSetController cont) {
		//this.opp= [SELECT Id,Name,Amount,StageName,CloseDate, AccountId FROM Opportunity];
        //controller = ApexPages.StandardSetController(opp);
    }
	
	

    public PageReference deleteThatOpp(){
          
        //Opportunity o= [SELECT Id FROM Opportunity WHERE Id=:opId];
        PageReference pr = Page.Opportunity_Home;
        //pr.setRedirect(true);
        try{ Database.delete(myOpp);}
        catch(DmlException de){
            ApexPages.addMessages(de);
        }

        
        pr.setRedirect(true);
       return pr;
   

}
}