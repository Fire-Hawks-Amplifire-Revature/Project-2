@isTest
public with sharing class SamsDataFactory {
    @testVisible
    public static List<Contact> makeUniqueAssociatedContacts(Integer numContacts, String accountId, String lastNameStem){
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 1; i <= numContacts; i++) {
            contacts.add(new Contact(lastName = lastNameStem + ' ' + i, accountId = accountId, contactType__c='Service Technician'));
        }
        return contacts;
    }

    @testVisible
    public static List<Contact> addEmailToContacts(List<Contact> contacts, Boolean isPositive){
        Integer i = 0;
        String domain;

        if(isPositive){
            domain = '@positive.com';
        } else {
            domain = '@negative.com';
        }

        for (Contact c : contacts) {
            c.email = 'test' + i + domain;
            i+=1;
        }
        return contacts;
    }
}