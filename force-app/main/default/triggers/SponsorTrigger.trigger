trigger SponsorTrigger on CAMPX__Sponsor__c (before insert, before update, after insert, after update) {
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            SponsorTriggerHandler.beforeInsertHandler(trigger.new);
        }
        when BEFORE_UPDATE{
            System.debug('Entering beforeUpdateHandler');
            SponsorTriggerHandler.beforeUpdateHandler(trigger.new, trigger.oldmap);
        }
        when AFTER_INSERT{
            System.debug('Entering afterInsertHandler');
            SponsorTriggerHandler.afterInsertHandler(trigger.new);
        }
        when AFTER_UPDATE{
            System.debug('Entering afterUpdateHandler');
            SponsorTriggerHandler.afterUpdateHandler(trigger.new, trigger.oldmap);
        }
    }

}