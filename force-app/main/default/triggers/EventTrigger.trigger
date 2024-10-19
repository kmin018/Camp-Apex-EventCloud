trigger EventTrigger on CAMPX__Event__c (before insert) {
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            EventTriggerHandler.updateEventStatus(trigger.new);
        }
    }
}