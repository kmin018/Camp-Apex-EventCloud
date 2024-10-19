public without sharing class EventTriggerHandler {
    public static void updateEventStatus(List<CAMPX__Event__c> newEventRecords) {
        for (CAMPX__Event__c event : newEventRecords) {
            event.CAMPX__Status__c = 'Planning';
        }

    }
}