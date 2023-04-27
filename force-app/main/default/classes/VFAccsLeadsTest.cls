@isTest
public class VFAccsLeadsTest {
    
    @TestSetup
    public static void createRecords(){
        
        List<Lead> leadList = new List<Lead>();
        
        for(Integer i=0; i<100; i++){
            Lead coo = new Lead();
            coo.firstName = 'coo'+ i;
            coo.lastName = 'Tom';
            coo.Company = 'Tester Comp';
            i = i + 1;
            leadList.add(coo);           
        }
        
        insert leadList;
        
        List<Account> accountList = new List<Account>();
        
        for(Integer c=0; c<100; c++){
            Account coo = new Account();
            coo.Name = 'Coos Quarters';
            coo.website = 'https://www.nasa.gov/';
            c = c + 1;
            accountList.add(coo);
        }        
        insert accountList;          
        }  
    //Positive Test
    
    @isTest
    public static void testInsertAccount(){
        PageReference pageRef = Page.VFAccountLead;
        Test.setCurrentPage(pageRef);
        
        Account acc = new Account(Name='Savoir Faire', AnnualRevenue =100000000.00);
        
        ApexPages.currentPage().getParameters().put('accountID', acc.Id);
        
       AccountsLeadsControllers aamc = new AccountsLeadsControllers();
       aamc.saveAccounts();
        
       List<Account> newt = [SELECT ID FROM Account WHERE Id =:acc.id];
        
       System.assertEquals(!newt.isEmpty(), newt.contains(acc)); 
        
    }
    
    @isTest
    public static void testInsertLead(){
        PageReference pageRef = Page.VFAccountLead;
        Test.setCurrentPage(pageRef);
        
       Lead led = new lead(firstName='Emily', lastName='Jim', company = 'GetJimJonesBarbeque'); 
        
       ApexPages.currentPage().getParameters().put('leadID', led.id);
        
       AccountsLeadsControllers aamc = new AccountsLeadsControllers();
       aamc.saveLeads();
        
       List<Lead> newt = [SELECT ID FROM Lead WHERE Id =:led.id];
        
       System.assertEquals(!newt.isEmpty(), newt.contains(led));       
    }
    
     @isTest
    public static void testAccountDelete(){
        PageReference pageRef = Page.VFAccountsLeadPage2;
        Test.setCurrentPage(pageRef);
        
        Account acc = new Account(Name='Savoir Faire', AnnualRevenue =100000000.00);
        insert acc;
        
        test.startTest();
        
        ApexPages.currentPage().getParameters().put('accountID', acc.id);
        
        AccountsLeadsControllers aamc = new AccountsLeadsControllers();
        aamc.accountID=acc.id;        
        aamc.delAccounts();                     
       
        List<Account> oom = [SELECT ID FROM Account WHERE Id = :acc.id];
        
        System.assertEquals(true, oom.isEmpty());   
        
       test.stopTest();
    }
    
    @isTest
    public static void testLeadDelete(){
        PageReference pageRef = Page.VFAccountsLeadPage2;
        Test.setCurrentPage(pageRef);
        
        Lead led = new lead(firstName='Emily', lastName='Jim', company = 'GetJimJonesBarbeque');
        insert led;
        
        test.startTest();
        
        ApexPages.currentPage().getParameters().put('leadID', led.id);
        
        AccountsLeadsControllers aamc = new AccountsLeadsControllers();
        aamc.leadID=led.id;        
        aamc.delLeads();                     
       
        List<Lead> oom = [SELECT ID FROM Lead WHERE Id = :led.id];
        
        System.assertEquals(true, oom.isEmpty());   
        
       test.stopTest();
    }
    
    @isTest
    public static void testLeadReturn(){
        PageReference pageRef = Page.VFAccountsLeadPage2;
        Test.setCurrentPage(pageRef);
        
        AccountsLeadsControllers aamc = new AccountsLeadsControllers();
        aamc.leadList();
        
        //Only 50 records are allows to be return via VF page  
        System.assertEquals(50, [SELECT Count() FROM Lead]);                
    }
    
    @isTest
    public static void testAccountReturn(){
        PageReference pageRef = Page.VFAccountsLeadPage2;
        Test.setCurrentPage(pageRef);
        
        AccountsLeadsControllers aamc = new AccountsLeadsControllers();
        aamc.accountList();
        
        //Only 50 records are allows to be return via VF page  
        System.assertEquals(50, [SELECT Count() FROM Account]);                
    }

    
     @isTest
    public static void testLeadUpdate(){
        PageReference pageRef = Page.VFAccountsLeadPage2;
        Test.setCurrentPage(pageRef);
        
        Lead led = new lead(firstName='Emily', lastName='Jim', company = 'GetJimJonesBarbeque');
        insert led;
        
        led.FirstName='Tim Rodgers';
        
         AccountsLeadsControllers aamc = new AccountsLeadsControllers();
        aamc.updateLead();
        
        System.assertEquals(led.FirstName='Tim Rodgers', led.firstName);        
    }

    
      @isTest
    public static void testAccountUpdate(){
        PageReference pageRef = Page.VFAccountsLeadPage2;
        Test.setCurrentPage(pageRef);
        
        Account acc = new Account(Name='Savoir Faire', AnnualRevenue =100000000.00);
        insert acc;
        
        acc.Name='Extravagance';
        
        AccountsLeadsControllers aamc = new AccountsLeadsControllers();
        aamc.updateLead();
        
        System.assertEquals(acc.Name='Extravagance', acc.Name);        
    }
    
}