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
    public static void positiveSingleInsert(){
        Account associatedAccount1 = [SELECT Id FROM Account WHERE name='Account 123'];

        Contact newContact = new Contact(accountId=associatedAccount1.Id, firstName='New Test', lastName='Contact', email='test@positive.com', contactType__c='Service Technician');
        Database.SaveResult sr = Database.insert(newContact);

        System.assert(sr.isSuccess());
    }

    @isTest
    public static void positiveSingleUpdate(){       
        Contact updateContact = [SELECT Id, email FROM Contact WHERE firstName='Main Test' AND lastName='Contact'];
        updateContact.description = 'I am a test contact.';
    
        Database.saveResult sr =  Database.update(updateContact);
    
        System.assert(sr.isSuccess());
    }
    
    @isTest
    public static void negativeSingleInsert(){
        Account associatedAccount1 = [SELECT Id FROM Account WHERE name='Account 123'];

        Contact negativeTestContact1 = new Contact(accountId=associatedAccount1.Id, firstName='Main Test', lastName='Contact', email='test@negative.com', contactType__c='Service Technician');

        Database.saveResult srNegativeInsert = Database.insert(negativeTestContact1, false);

        System.assert(!srNegativeInsert.isSuccess());
    }

    @isTest
    public static void negativeSingleUpdate(){        
        Contact updateContact = [SELECT Id, email FROM Contact WHERE firstName='Main Test' AND lastName='Contact'];
        updateContact.email = 'test@negative.com';
    
        Database.saveResult sr =  Database.update(updateContact, false);
    
        System.assert(!sr.isSuccess());
    }

    @isTest
    public static void positiveBulkInsert(){
        Integer numContacts = 3;
        Account associatedAccount = [SELECT Id FROM Account WHERE name='Account 123'];
        List<Contact> contacts = SamsDataFactory.makeUniqueAssociatedContacts(numContacts, associatedAccount.Id, 'Bulk Contact');

        contacts = SamsDataFactory.addEmailToContacts(contacts, true);

        List<Database.SaveResult> srList = Database.insert(contacts);
        
        for(Database.SaveResult result : srList){
            System.assert(result.isSuccess());
        }
    }

    @isTest
    public static void positiveBulkUpdate(){
        Integer numContacts = 3;
        Account associatedAccount = [SELECT Id FROM Account WHERE name='Account 123'];
        List<Contact> contacts = SamsDataFactory.makeUniqueAssociatedContacts(numContacts, associatedAccount.Id, 'Bulk Contact');
        contacts = SamsDataFactory.addEmailToContacts(contacts, true);

        insert contacts;

        for(Contact c : contacts){
            c.lastName = c.lastName + 'v2';
        }

        List<Database.SaveResult> srList = Database.update(contacts);
        
        for(Database.SaveResult result : srList){
            System.assert(result.isSuccess());
        }

        List<Contact> checkContacts = [SELECT lastName FROM Contact WHERE accountId=:associatedAccount.Id AND lastName LIKE 'Bulk Contact%'];
        System.assertEquals(numContacts, checkContacts.size());
    }

    @isTest
    public static void negativeBulkInsert(){
        Integer numContacts = 3;
        Account associatedAccount = [SELECT Id FROM Account WHERE name='Account 123'];
        List<Contact> contacts = SamsDataFactory.makeUniqueAssociatedContacts(numContacts, associatedAccount.Id, 'Bulk Contact');

        contacts = SamsDataFactory.addEmailToContacts(contacts, false);

        List<Database.SaveResult> srList = Database.insert(contacts, false);
        System.debug([SELECT email, lastName FROM Contact]);
        
        for(Database.SaveResult result : srList){
            System.assert(!result.isSuccess());
        }
    }

    @isTest
    public static void negativeBulkUpdate(){
        Integer numContacts = 3;
        Account associatedAccount = [SELECT Id FROM Account WHERE name='Account 123'];
        List<Contact> contacts = SamsDataFactory.makeUniqueAssociatedContacts(numContacts, associatedAccount.Id, 'Bulk Contact');
        contacts = SamsDataFactory.addEmailToContacts(contacts, false);

        insert contacts;

        for(Contact c : contacts){
            c.lastName = c.lastName + 'v2';
        }

        List<Database.SaveResult> srList = Database.update(contacts);
        
        for(Database.SaveResult result : srList){
            System.assert(!result.isSuccess());
        }
    }
}