trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            new ContactTriggerHelper_EmailSimilarity();
        }
        when BEFORE_UPDATE {
            new ContactTriggerHelper_EmailSimilarity();
        }
        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {
            
        }
        when AFTER_UPDATE {
            
        }
        when AFTER_DELETE {
            
        }
        when AFTER_UNDELETE {
            
        }
    }
}