public with sharing class AccountsLeadsControllers {
    
  public Lead lead{get;set;}
  public Account account{get;set;}
  public String accountID{get;set;}
  public String leadID{get;set;}   
  
  public List<Account> accountList{get;set;}
  public List<Lead> leadList{get;set;}
  
  //creating new contacts
  public AccountsLeadsControllers(){
      this.account = new Account();  
      this.Lead = new Lead(); 
      this.accountList = [SELECT Name, Phone, AnnualRevenue FROM Account With SECURITY_ENFORCED];
      this.leadList = [SELECT firstName, lastName, Email, Phone, company FROM Lead With SECURITY_ENFORCED]; 
  } 
  
  public PageReference saveLeads(){ 
       PageReference myPage = Page.VFAccountsLeadPage2;
       myPage.setRedirect(true);
            if(Schema.sObjectType.Lead.isCreateable()){
                try{
                    upsert this.lead;
                }catch(DmlException ot){
                    ApexPages.addMessages(ot);
                }
              }
      return myPage;
            }                  

  public PageReference saveAccounts(){ 
      PageReference myPage = Page.VFAccountsLeadPage2;
      myPage.setRedirect(true);
            if(Schema.sObjectType.Account.isCreateable() && Schema.sObjectType.Account.fields.Name.isUpdateable()){
              try{
                upsert this.account;
              } catch(DmlException an){
                ApexPages.addMessages(an);
                }  
              }
      return myPage;
            }
    
  public List<Lead> leadList(){
      return leadList;
  }          
  public List<Account> accountList(){
      return accountList; 
  }    
  
  public PageReference delLeads(){        
      PageReference myPage = Page.VFAccountsLeadPage2;
      myPage.setRedirect(true);
      
      if(Schema.SObjectType.Lead.isDeletable()){ 
          try {
         Database.delete(this.leadID); 
          } catch(DmlException e){
             ApexPages.addMessages(e);
         }             
      }       
      return myPage;
  }
  
  public PageReference delAccounts(){        
      PageReference myPage = Page.VFAccountsLeadPage2;
      myPage.setRedirect(true);
      
      if(Schema.SObjectType.Account.isDeletable()){  
       Database.delete(this.accountID);     
      }       
      return myPage;
    }      
  
  public PageReference updateAccount(){        
      PageReference myPage = Page.VFAccountsLeadPage2;      
      myPage.setRedirect(true);
      
     if(Schema.SObjectType.Account.isUpdateable()){
       Database.update(this.accountList);
      }        
      return myPage;
            }
  
   public PageReference updateLead(){ 
       PageReference myPage = Page.VFAccountsLeadPage2; 
       myPage.setRedirect(true);
       
       if(Schema.SObjectType.Lead.isUpdateable()){
       Database.update(this.leadList);
        }                                    
       return myPage;
            }
}