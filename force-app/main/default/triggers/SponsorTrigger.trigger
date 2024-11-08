trigger SponsorTrigger on CAMPX__Sponsor__c (before insert, before update) {
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            SponsorTriggerHandler.beforeInsertHandler(trigger.new);
        }
        when BEFORE_UPDATE{
            System.debug('Entering beforeUpdateHandler');
            SponsorTriggerHandler.beforeUpdateHandler(trigger.new, trigger.oldmap);
        }
    }

}