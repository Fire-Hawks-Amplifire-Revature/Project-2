@testVisible
public with sharing class ContactTriggerHelper_EmailSimilarity {
    public ContactTriggerHelper_EmailSimilarity(List<Contact> contacts) {

        Set<Id> triggerContactIds = new Set<Id>();
        Set<Id> associatedAccountIds = new Set<Id>();

        for (Contact c : contacts) {
            if(c.accountId != null && c.email != null){
                //only check contacts with associated accounts and emails
                triggerContactIds.add(c.Id);
                associatedAccountIds.add(c.accountId);
            }
        }
        
        List<Contact> associatedContacts = [SELECT accountId, email FROM Contact WHERE accountId IN :associatedAccountIds WITH USER_MODE];

        if(associatedContacts.size() > 0){
            for(Contact associatedContact : associatedContacts){
<<<<<<< HEAD
                if(associatedContact.email != null){
                    String oldContactDomain = associatedContact.email.substringAfter('@');
                    for(Contact c : contacts){
                        if(c.accountId == associatedContact.accountId  && c != associatedContact && c.email != null){
                            String triggerContactDomain = c.email.substringAfter('@');
                            if(oldContactDomain != triggerContactDomain){
                                c.addError('Invalid Email Domain - Make sure your email domain matches other contacts associated with the account');
                            }
=======
                String oldContactDomain = associatedContact.email.substringAfter('@');
                for(Contact c : contacts){
                    if(c.accountId == associatedContact.accountId  && c != associatedContact){
                        String triggerContactDomain = c.email.substringAfter('@');
                        if(oldContactDomain != triggerContactDomain){
                            c.addError('Invalid Email Domain - Make sure your email domain matches other contacts associated with the account');
>>>>>>> 03ec958a6d0cbf58670c907af1535623bd62c4ff
                        }
                    }
                }
            }    
        }
    }
}