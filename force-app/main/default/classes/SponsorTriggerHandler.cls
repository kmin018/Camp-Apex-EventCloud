public without sharing class SponsorTriggerHandler {
    public static void beforeInsertHandler(List<CAMPX__Sponsor__c> newSponsors) {
        defaultingSponsorStatus(newSponsors);
        enforcingEmailRequirements(newSponsors);
    }

    private static void defaultingSponsorStatus(List<CAMPX__Sponsor__c> newSponsors){
        for (CAMPX__Sponsor__c sponsor : newSponsors) {
            if (sponsor.CAMPX__Status__c == null){
                sponsor.CAMPX__Status__c = 'Pending';
            }
        }
    }

    private static void enforcingEmailRequirements (List<CAMPX__Sponsor__c> newSponsors){
        for (CAMPX__Sponsor__c sponsor : newSponsors){
            if (sponsor.CAMPX__Email__c == null){
                sponsor.addError ('A sponsor can not be created without an email address');
            }
        }
    }
}