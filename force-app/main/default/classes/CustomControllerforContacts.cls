public with sharing class CustomControllerforContacts {   
    
    
    public Contact contact{get;set;}
    public String contactID{get;set;}
    
    public List<Contact> customerAccList{get;set;}
    public List<Contact> serviceTechnicianList{get;set;}
    
    //creating new contacts
    public CustomControllerForContacts(){
        this.Contact = new Contact();  
        this.customerAccList = [SELECT FirstName, LastName, Email, Phone, ContactType__c FROM Contact WHERE ContactType__c = 'Customer' WITH SECURITY_ENFORCED];
        this.serviceTechnicianList = [SELECT FirstName, LastName, Email, Phone, ContactType__c FROM Contact Where ContactType__c ='Service Technician' WITH SECURITY_ENFORCED];   
    }
    
    public PageReference saveCons(){ 
        PageReference myPage = Page.ContactsVisualForcePage2;
        myPage.setRedirect(true);
        if(Schema.SObjectType.Contact.isCreateable() &&Schema.SObjectType.Contact.isUpdateable()){
      try{
        upsert this.contact;
       } catch(DmlException an){
        ApexPages.addMessages(an);
        }  
      } 
        return myPage;
    }             
    
    public List<Contact> getcustomerAccList(){
        return customerAccList;
    }
          
    public List<Contact> getserviceTechnicianList(){
        return serviceTechnicianList; 
    }    
    
    public PageReference delRecords(){
        PageReference myPage = Page.ContactsVisualForcePage2;
        myPage.setRedirect(true); 
        
        if(Schema.SObjectType.Contact.isDeletable()) {
        try {
    		Database.delete(this.contactID);
		} catch(DmlException an) {
    		ApexPages.addMessages(an);
            return null;
			}            
        } 
        
        return myPage;
    }  

    public PageReference updateServiceTechs(){
        PageReference myPage = Page.ContactsVisualForcePage2;
        myPage.setRedirect(true);
        
        if(Schema.SObjectType.Contact.isUpdateable()){
            try{
        Database.update(this.serviceTechnicianList);
        } catch(DmlException exa){
            ApexPages.addMessages(exa);
            return null;
        }
      }
        return myPage;
  }

    public PageReference updateCustomerAccs(){
        PageReference myPage = Page.ContactsVisualForcePage2;
        myPage.setRedirect(true);
        
        if(Schema.SObjectType.Contact.isUpdateable()){
            try{
        Database.update(this.customerAccList);
            } catch(DmlException alo){
              ApexPages.addMessages(alo);
                return null;
            }
        }
        return myPage;
    }
  }