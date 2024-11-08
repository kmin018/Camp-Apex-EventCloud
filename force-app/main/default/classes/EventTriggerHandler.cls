public without sharing class EventTriggerHandler {
    // BEFORE INSERT Method
    public static void beforeInsertHandler(List<CAMPX__Event__c> newEvents){
        updateEventStatus(newEvents);
        setNetRevenue(newEvents);
    }
    
    private static void updateEventStatus(List<CAMPX__Event__c> newEvents) {
        for (CAMPX__Event__c event : newEvents) {
            event.CAMPX__Status__c = 'Planning';
            event.CAMPX__StatusChangeDate__c = DateTime.now();
        }
    }

    private static void setNetRevenue(List<CAMPX__Event__c> newEvents){
        for (CAMPX__Event__c event : newEvents){
            if (event.CAMPX__GrossRevenue__c == null || event.CAMPX__TotalExpenses__c == null){
                event.CAMPX__NetRevenue__c = null;
            }
            else {
                event.CAMPX__NetRevenue__c = event.CAMPX__GrossRevenue__c - event.CAMPX__TotalExpenses__c;
            }
        }
    }

    // BEFORE UPDATE Method
    public static void beforeUpdateHandler(List<CAMPX__Event__c> newEvents, Map<Id, CAMPX__Event__c> oldEventsMap){
        captureEventStatusChange(newEvents, oldEventsMap);
        updateNetRevenue(newEvents, oldEventsMap);
    }

    private static void captureEventStatusChange(List<CAMPX__Event__c> newEvents, Map<Id, CAMPX__Event__c> oldEventsMap) {
        for (CAMPX__Event__c event : newEvents) {
            CAMPX__Event__c oldEvent = oldEventsMap.get(event.Id);
            If (event.CAMPX__Status__c != oldEvent?.CAMPX__Status__c){
                event.CAMPX__StatusChangeDate__c = DateTime.now();
            }
        }
    }

    private static void updateNetRevenue(List<CAMPX__Event__c> newEvents, Map<Id, CAMPX__Event__c> oldEventsMap){
        for (CAMPX__Event__c event : newEvents){
            CAMPX__Event__c oldEvent = oldEventsMap.get(event.Id);
            if (event.CAMPX__GrossRevenue__c == null || event.CAMPX__TotalExpenses__c == null){
                event.CAMPX__NetRevenue__c = null;
            }
            else if (event.CAMPX__GrossRevenue__c  != oldEvent.CAMPX__GrossRevenue__c || event.CAMPX__TotalExpenses__c != oldEvent.CAMPX__TotalExpenses__c){
                event.CAMPX__NetRevenue__c = event.CAMPX__GrossRevenue__c - event.CAMPX__TotalExpenses__c;
            }
        }
    }
}