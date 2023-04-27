public class CSSTriggerHelper_Clean {
    
    public static Boolean isFirstTime=true;


    public CSSTriggerHelper_Clean(List<Customer_Success_Story__c> cssTrig)
    {
        Set<Id> accIdList= new Set<Id>();

        for(Customer_Success_Story__c c:cssTrig)
        {
            accIdList.add(c.Account__c);
        }

        List<Account> accCompile= [SELECT Id, (SELECT Account__c, Rating__c,Ranking__c FROM Customer_Success_Stories__r ORDER BY Rating__c DESC NULLS LAST) FROM Account WHERE Account.Id IN :accIdList];
        //System.debug(accCompile);
        List<Customer_Success_Story__c> updated=new List<Customer_Success_Story__c>();
        for(Account acc:accCompile)
        {
            Integer inc=1;
            for( Customer_Success_Story__c c:acc.Customer_Success_Stories__r)
            {
                if(inc>1&&c.Rating__c==acc.Customer_Success_Stories__r[inc-2].Rating__c)
                c.Ranking__c=acc.Customer_Success_Stories__r[inc-2].Ranking__c;
                else
                c.Ranking__c=inc;
                updated.add(c);
                System.debug(c);
                inc++;
            }
        }

        update(updated);
        isFirstTime=true;
    }

}