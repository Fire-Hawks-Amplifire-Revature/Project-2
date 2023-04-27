trigger CSSTrigger on Customer_Success_Story__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on Trigger.operationType{
    when BEFORE_INSERT {
        //new CSSTriggerHelper_Clean(Trigger.new);
    }
    when BEFORE_UPDATE {
        //new CSSTriggerHelper_Clean(Trigger.new);
    }
    when BEFORE_DELETE {
        //new CSSTriggerHelper(Trigger.new);
    }
    when AFTER_INSERT {
        CSSTriggerHelper_Clean.isFirstTime=false;
        new CSSTriggerHelper_clean(Trigger.new);
    }
    when AFTER_UPDATE {
        if(CSSTriggerHelper_Clean.isFirstTime){
            CSSTriggerHelper_Clean.isFirstTime=false;
            new CSSTriggerHelper_clean(Trigger.new);
            
        }
    }
    when AFTER_DELETE {
        if(CSSTriggerHelper_Clean.isFirstTime){
            CSSTriggerHelper_Clean.isFirstTime=false;
            new CSSTriggerHelper_clean(Trigger.old);
            
        }
    }
    when AFTER_UNDELETE {

        if(CSSTriggerHelper_Clean.isFirstTime){
            CSSTriggerHelper_Clean.isFirstTime=false;
            new CSSTriggerHelper_clean(Trigger.new);
            
        }
    }

}
}