public without sharing class SponsorTriggerHandler {
    // BEFORE INSERT Method    
    public static void beforeInsertHandler(List<CAMPX__Sponsor__c> newSponsors) {
        defaultingSponsorStatus(newSponsors);
        enforcingEmailRequirements(newSponsors);
        updateSponsorTier(newSponsors);
        conditionalSponsorStatusCheckOnCreation(newSponsors);
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

    private static void updateSponsorTier(List<CAMPX__Sponsor__c> newSponsors){
        for (CAMPX__Sponsor__c sponsor : newSponsors) {
            if (sponsor.CAMPX__ContributionAmount__c <= 0){
                sponsor.CAMPX__Tier__c = '';
            }
            else if (sponsor.CAMPX__ContributionAmount__c < 1000){
                sponsor.CAMPX__Tier__c = 'Bronze';
            }
            else if (sponsor.CAMPX__ContributionAmount__c < 5000){
                sponsor.CAMPX__Tier__c = 'Silver';
            } 
            else if (sponsor.CAMPX__ContributionAmount__c >= 5000){
                sponsor.CAMPX__Tier__c = 'Gold';
            }
            else {
                sponsor.CAMPX__Tier__c = '';
            }
        }
    }

    private static void conditionalSponsorStatusCheckOnCreation (List<CAMPX__Sponsor__c> newSponsors){
        for (CAMPX__Sponsor__c sponsor : newSponsors) {
            if (sponsor.CAMPX__Status__c == 'Accepted' && sponsor.CAMPX__Event__c == null){
                sponsor.addError('A Sponsor must be associated with an event before being Accepted.');
            }
        }
    }

    public static void beforeUpdateHandler (List<CAMPX__Sponsor__c> newSponsors, Map<Id, CAMPX__Sponsor__c> oldSponsorsMap){
        conditionalSponsorStatusCheckOnUpdate(newSponsors, oldSponsorsMap);
    }

    private static void conditionalSponsorStatusCheckOnUpdate (List<CAMPX__Sponsor__c> newSponsors, Map<Id, CAMPX__Sponsor__c> oldSponsorsMap){
        System.debug('Entering conditionalSponsorStatusCheckOnUpdate');
        for (CAMPX__Sponsor__c sponsor : newSponsors) {
            CAMPX__Sponsor__c oldSponsor = oldSponsorsMap.get(sponsor.Id);
            System.debug('Processing sponsor: ' + sponsor.Id);
            System.debug('New Status: ' + sponsor.CAMPX__Status__c);
            System.debug('Old Status: ' + oldSponsor.CAMPX__Status__c);
            System.debug('Event: ' + sponsor.CAMPX__Event__c);
            if (sponsor.CAMPX__Status__c == 'Accepted' && oldSponsor.CAMPX__Status__c != 'Accepted' && sponsor.CAMPX__Event__c == null){
                sponsor.addError('A Sponsor must be associated with an event before being Accepted.');
            }
        }
    }
}