@isTest
public with sharing class TESTContactTriggerHelper_EmailSimilarity {
    @isTest
    public static void positiveSingleTest(){
        Account associatedAccount = new Account(name='Account 123');
        insert associatedAccount;
        System.debug('associatedAccount: ' + associatedAccount);

        Contact associatedContact = new Contact(accountId=associatedAccount.Id, firstName='Associated Test', lastName='Contact', email='test@positive.com');
        System.debug('associatedContact: ' + associatedContact);
        insert associatedContact;
        System.debug('Test');
        // Database.SaveResult result = Database.insert(associatedContact);
        // System.debug('Insert Contact Result: ' + result.isSuccess());
        // System.debug('associatedContact: ' + associatedContact);

        Contact testContact = new Contact(accountId=associatedAccount.Id, firstName='Main Test', lastName='Contact', email='test@positive.com');
        
        Test.startTest();
        insert testContact;
        Test.stopTest();

        System.debug('Test Hello 3');
    }
}