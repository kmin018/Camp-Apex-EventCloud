public without sharing class SponsorTriggerHandler {
    public static void beforeInsertHandler(List<CAMPX__Sponsor__c> newSponsors) {
        defaultingSponsorStatus(newSponsors);
    }

    private static void defaultingSponsorStatus(List<CAMPX__Sponsor__c> newSponsors){
        for (CAMPX__Sponsor__c sponsor : newSponsors) {
            if (sponsor.CAMPX__Status__c == null){
                sponsor.CAMPX__Status__c = 'Pending';
            }
        }
    }
}