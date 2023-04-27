@isTest
public class oppHomeTester {
    @isTest
    public static void oppHomeTest(){
        PageReference pageRef = Page.Opportunity_Home;
        Test.setCurrentPage(pageRef);
        Account a=new Account(Name='Tester Account');
        insert a;
        Opportunity opp = new Opportunity(Name='Test Opportunity a', AccountId=a.Id, CloseDate=System.today(),StageName='Qualification');
        insert opp;
        

        List<Opportunity> oppList = new List<Opportunity>();
        oppHomeExtension ohe = new oppHomeExtension(new ApexPages.StandardSetController(oppList));
        ohe.myOpp = opp.Id;
        //System.debug(ohe.oppor.Name);
        ohe.deleteThatOpp();
        ohe.deleteThatOpp();
        List<Opportunity> myOpp = [SELECT Id FROM Opportunity];
        System.assertEquals(0, myOpp.size());
    }

    /*
    @TestSetup
    static void makeData(){
        Account a=new Account(Name='Tester Account');
        insert a;
        Opportunity oa=new Opportunity(Name='Test Opportunity a', AccountId=a, CloseDate=Sytem.today(),StageName='Qualification');
        insert oa;
    }

    */
}