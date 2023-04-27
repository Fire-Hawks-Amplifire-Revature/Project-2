public with sharing class oppCreateExtension {
    public Opportunity oppor{get;set;}

   
    
    public oppCreateExtension() {
     
        oppor=new Opportunity();

    }
    /*public Opportunity getOppor()
    {

        return this.oppor;
    }*/
    public PageReference saveNewOpp(){
        PageReference pr = Page.Opportunity_Home;

               
        try{
                insert this.oppor;

            }catch(DmlException de){
                ApexPages.addMessages(de);
            }
            
      return pr;
}
}