trigger EventTrigger on CAMPX__Event__c (before insert, before update) {
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            EventTriggerHandler.beforeInsertHandler(trigger.new);
        }
        when BEFORE_UPDATE{
            EventTriggerHandler.beforeUpdateHandler(trigger.new, trigger.oldmap);
        }
    }
}