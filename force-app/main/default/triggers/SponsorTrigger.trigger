trigger SponsorTrigger on CAMPX__Sponsor__c (before insert) {
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            SponsorTriggerHandler.beforeInsertHandler(trigger.new);
        }
    }

}