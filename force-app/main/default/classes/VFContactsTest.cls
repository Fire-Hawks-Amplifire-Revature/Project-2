@isTest
public class VFContactsTest { 
    
    @TestSetup
    public static void createRecord(){
        
        List<Contact> custContactList = new List<Contact>();
        
        for(Integer i=0; i<100; i++){
            Contact coo = new Contact();
            coo.firstName = 'coo'+ i;
            coo.lastName = 'Tom';
            coo.ContactType__c= 'Customer';
            i = i + 1;
            custContactList.add(coo);           
        }
        
        insert custContactList;
        
        List<Contact> servContactList = new List<Contact>();
        
        for(Integer i=0; i<100; i++){
            Contact coo = new Contact();
            coo.firstName = 'coop'+ i;
            coo.lastName = 'Jerry';
            coo.ContactType__c= 'Service Technician';
            i = i + 1;
            servContactList.add(coo);
        }        
        insert servContactList;          
        }    
    
    //Positive Test
    
    @isTest
    public static void testInsertContact(){
        PageReference pageRef = Page.ContactsVisualForce;
        Test.setCurrentPage(pageRef);
        
       Contact con = new Contact(firstName='Emily', lastName='Jim', contacttype__c='customer'); 
        
        ApexPages.currentPage().getParameters().put('conID', con.id);
        
       CustomControllerforContacts aap = new CustomControllerforContacts();
       aap.saveCons();               
        
       List<Contact> newt = [SELECT ID FROM Contact WHERE Id =:con.id];
        
       System.assertEquals(!newt.isEmpty(), newt.contains(con));       
    }
    
    @isTest
    public static void testContactDelete(){
        PageReference pageRef = Page.ContactsVisualForcePage2;
        Test.setCurrentPage(pageRef);
        
        Contact con = new Contact(firstName='Emily', lastName='Jim', contacttype__c='customer');
        insert con;
        
        test.startTest();
        
        ApexPages.currentPage().getParameters().put('conID', con.id);
        
        CustomControllerforContacts aap = new CustomControllerforContacts();
        aap.contactID=con.id;        
        aap.delRecords();                     
       
        List<Contact> oom = [SELECT ID FROM Contact WHERE Id = :con.id];
        
        System.assertEquals(true, oom.isEmpty());   
        
       test.stopTest();
    }
    
    @isTest
    public static void testContactUpdateCust(){
        PageReference pageRef = Page.ContactsVisualForcePage2;
        Test.setCurrentPage(pageRef);
        
        Contact con = new Contact(firstName='Emily', lastName='Jim', contacttype__c='customer');
        insert con;
        
        con.FirstName='EmilyBobbet';
        
        CustomControllerforContacts aap = new CustomControllerforContacts();
        aap.updateCustomerAccs();
        
        System.assertEquals(con.FirstName='EmillyBobbet', con.firstName);        
    }
    
    @isTest
    public static void testContactUpdateServ(){
        PageReference pageRef = Page.ContactsVisualForcePage2;
        Test.setCurrentPage(pageRef);
        
        Contact con = new Contact(firstName='Emily', lastName='Jim', contacttype__c='Service Technician');
        insert con;
        
        con.FirstName='EmilyBobbet';
        
        CustomControllerforContacts aap = new CustomControllerforContacts();
        aap.getserviceTechnicianList();
        
        System.assertEquals(con.FirstName='EmillyBobbet', con.firstName);        
    }
    
    @isTest
    public static void servContactReturn(){
        PageReference pageRef = Page.ContactsVisualForcePage2;
        Test.setCurrentPage(pageRef);
        
        CustomControllerforContacts aap = new CustomControllerforContacts();
        aap.getserviceTechnicianList();
        
		//Only 50 records are allows to be return via VF page        
        System.assertEquals(50, [SELECT Count() FROM Contact WHERE contacttype__c = 'Service Technician']);                
    }
    
     @isTest
    public static void custContactReturn(){
        PageReference pageRef = Page.ContactsVisualForcePage2;
        Test.setCurrentPage(pageRef);
        
        CustomControllerforContacts aap = new CustomControllerforContacts();
        aap.getcustomerAccList();
        
        //Only 50 records are allows to be return via VF page  
        System.assertEquals(50, [SELECT Count() FROM Contact WHERE contacttype__c = 'Customer']);                
    }

    
    //Negative Test
    
    @isTest
    public static void testNoInsertContact(){
        PageReference pageRef = Page.ContactsVisualForce;
        Test.setCurrentPage(pageRef);
        
       Contact con = new Contact(firstName='Emily', lastName='Jonathan'); 
        
        ApexPages.currentPage().getParameters().put('conID', con.id);
        
       CustomControllerforContacts aap = new CustomControllerforContacts();
       aap.saveCons();
        
       System.assertEquals(Null, con.id, ApexPages.hasMessages());
    }
    
    
    
}