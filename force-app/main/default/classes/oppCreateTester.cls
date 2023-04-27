@isTest
public with sharing class oppCreateTester {
    @isTest
    public static void oppCreateTester() {
        PageReference pageRef = Page.Opportunity_Create;
        Test.setCurrentPage(pageRef);
        Account a=new Account(Name='Tester Account');
        insert a;
        oppCreateExtension oce= new oppCreateExtension();

        //Opportunity opp = new Opportunity(Name='Test Opportunity a', AccountId=a.Id, CloseDate=System.today(),StageName='Qualification');
        oce.oppor=new Opportunity(Name='Test Opportunity a', AccountId=a.Id, CloseDate=System.today(),StageName='Qualification');

        oce.saveNewOpp();
        oce.oppor=new Opportunity();
        oce.saveNewOpp();
    }
}