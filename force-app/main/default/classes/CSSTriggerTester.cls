@isTest
public class CSSTriggerTester {

    @TestSetup
    static void createCSSTestData(){
        Account a= new Account(Name= 'tester account for CSS');
        
        insert a;
    }

    @isTest
    public static void cssTestMethod(){
    Account ac= [Select Id,Average_Success_Story_Rating__c FROM Account WHERE Name='tester account for CSS'];

        System.debug('Starting Avg rating: '+ac.Average_Success_Story_Rating__c);
        //good to have here to implement ratings
        Customer_Success_Story__c custa=new Customer_Success_Story__c(Account__c=ac.Id,Name='tester success a',Rating__c=4.5);
        Customer_Success_Story__c custb=new Customer_Success_Story__c(Account__c=ac.Id,Name='tester success b',Rating__c=4.5);
        Customer_Success_Story__c custc=new Customer_Success_Story__c(Account__c=ac.Id,Name='tester success a',Rating__c=5);
        Customer_Success_Story__c custd=new Customer_Success_Story__c(Account__c=ac.Id,Name='tester success d',Rating__c=4);
        insert custa;
        //System.debug(a+' custa: '+custa);
        insert custb;
       // System.debug(a+' \ncusta: '+custa+' \ncustb: '+custb);
        insert custc;
        //System.debug(a+' \tcusta: '+custa+' \tcustb: '+custb+' \tcustc: '+custc);
        insert custd;
        System.debug(ac+' custa: '+custa+' custb: '+custb+' custc: '+custc+' custd: '+custd);

        custa.Rating__c=5;
        update custa;
        
        System.debug(' custa: '+custa+'ranking'+custa.ranking__c);
        delete custc;
        System.debug(' custa: '+custa+' custb: '+custb+' custc: '+custc+' custd: '+custd);
        undelete custc;
        System.debug(' custa: '+custa+' custb: '+custb+' custc: '+custc+' custd: '+custd);







    }
}