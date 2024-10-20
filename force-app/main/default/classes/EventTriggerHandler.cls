public without sharing class EventTriggerHandler {
    // BEFORE INSERT Method
    public static void beforeInsertHandler(List<CAMPX__Event__c> newEvents){
        updateEventStatus(newEvents);
    }
    
    private static void updateEventStatus(List<CAMPX__Event__c> newEvents) {
        for (CAMPX__Event__c event : newEvents) {
            event.CAMPX__Status__c = 'Planning';
            event.CAMPX__StatusChangeDate__c = DateTime.now();
        }
    }

    // BEFORE UPDATE Method
    public static void beforeUpdateHandler(List<CAMPX__Event__c> newEvents, Map<Id, CAMPX__Event__c> oldEventsMap){
        captureEventStatusChange(newEvents, oldEventsMap);
    }

    private static void captureEventStatusChange(List<CAMPX__Event__c> newEvents, Map<Id, CAMPX__Event__c> oldEventsMap) {
        for (CAMPX__Event__c event : newEvents) {
            CAMPX__Event__c oldEvent = oldEventsMap.get(event.Id);
            If (event.CAMPX__Status__c != oldEvent.CAMPX__Status__c){
                event.CAMPX__StatusChangeDate__c = DateTime.now();
            }
        }
    }
}