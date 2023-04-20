@isTest
public with sharing class TESTContactTriggerHelper_EmailSimilarity {
    @testSetup
    public static void makeData(){
        Account associatedAccount1 = new Account(name='Account 123');
        insert associatedAccount1;

        Contact associatedContact1 = new Contact(accountId=associatedAccount1.Id, firstName='Main Test', lastName='Contact', email='test@positive.com', contactType__c='Service Technician');
        insert associatedContact1;
    }

    @isTest
    public static void positiveSingleInsertTest(){
        Account associatedAccount1 = [SELECT Id FROM Account WHERE name='Account 123'];

        Contact newContact = new Contact(accountId=associatedAccount1.Id, firstName='New Test', lastName='Contact', email='test@positive.com', contactType__c='Service Technician');
        Database.SaveResult sr = Database.insert(newContact);

        System.assert(sr.isSuccess());
    }

    @isTest
    public static void positiveSingleUpdateTest(){
        Account associatedAccount1 = [SELECT Id FROM Account WHERE name='Account 123'];
        
        Contact updateContact = [SELECT Id, email FROM Contact WHERE firstName='Main Test' AND lastName='Contact'];
        updateContact.description = 'I am a test contact.';
    
        Database.saveResult sr =  Database.update(updateContact);
    
        System.assert(sr.isSuccess());
    }
    
    @isTest
    public static void negativeSingleInsertTest(){
        Account associatedAccount1 = [SELECT Id FROM Account WHERE name='Account 123'];

        Contact negativeTestContact1 = new Contact(accountId=associatedAccount1.Id, firstName='Main Test', lastName='Contact', email='test@negative.com', contactType__c='Service Technician');

        Database.saveResult srNegativeInsert = Database.insert(negativeTestContact1, false);

        System.assert(!srNegativeInsert.isSuccess());
    }

    @isTest
    public static void negativeSingleUpdateTest(){
        Account associatedAccount1 = [SELECT Id FROM Account WHERE name='Account 123'];
        
        Contact updateContact = [SELECT Id, email FROM Contact WHERE firstName='Main Test' AND lastName='Contact'];
        updateContact.email = 'test@negative.com';
    
        Database.saveResult sr =  Database.update(updateContact, false);
    
        System.assert(!sr.isSuccess());
    }
}