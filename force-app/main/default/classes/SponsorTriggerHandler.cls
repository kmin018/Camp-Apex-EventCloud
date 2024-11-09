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

    public static void afterInsertHandler(List<CAMPX__Sponsor__c> newSponsors){
        updateGrossRevenue(newSponsors);
    }

    private static void updateGrossRevenue(List<CAMPX__Sponsor__c> newSponsors){
        // Set to hold Event Ids that need Gross Revenue recalculation

        Set<Id> eventIdsToUpdate = new Set<Id>();
        // Gather all related Event Ids for sponsors with Accepted Status
        for (CAMPX__Sponsor__c sponsor : newSponsors){
            Boolean isStatusAccepted = sponsor.CAMPX__Status__c == 'Accepted';
            if (isStatusAccepted){
                eventIdsToUpdate.add(sponsor.CAMPX__Event__c);
                System.debug('sponsor.CAMPX__Event__c:' + sponsor.CAMPX__Event__c);
            }
        }

        if (!eventIdsToUpdate .isEmpty()){
            List<CAMPX__Event__c> eventsToUpdate = new List<CAMPX__Event__c>();
            for (AggregateResult result : [SELECT CAMPX__Event__c, SUM(CAMPX__ContributionAmount__c) sumAmount FROM CAMPX__Sponsor__c WHERE CAMPX__Event__c IN :eventIdsToUpdate  AND CAMPX__Status__c = 'Accepted' GROUP BY CAMPX__Event__c]){
                Id eventId = (Id) result.get('CAMPX__Event__c');
                Decimal totalAmount = (Decimal) result.get('sumAmount');

                eventsToUpdate.add(new CAMPX__Event__c(
                    Id = eventId, 
                    CAMPX__GrossRevenue__c = totalAmount
                ));
            }
            if (!eventsToUpdate.isEmpty()){
                update eventsToUpdate;
            }

        }

    }

    public static void beforeUpdateHandler (List<CAMPX__Sponsor__c> newSponsors, Map<Id, CAMPX__Sponsor__c> oldSponsorsMap){
        conditionalSponsorStatusCheckOnUpdate(newSponsors, oldSponsorsMap);
    }

    private static void conditionalSponsorStatusCheckOnUpdate (List<CAMPX__Sponsor__c> newSponsors, Map<Id, CAMPX__Sponsor__c> oldSponsorsMap){
        // System.debug('Entering conditionalSponsorStatusCheckOnUpdate');
        for (CAMPX__Sponsor__c sponsor : newSponsors) {
            CAMPX__Sponsor__c oldSponsor = oldSponsorsMap.get(sponsor.Id);
            // System.debug('Processing sponsor: ' + sponsor.Id);
            // System.debug('New Status: ' + sponsor.CAMPX__Status__c);
            // System.debug('Old Status: ' + oldSponsor.CAMPX__Status__c);
            // System.debug('Event: ' + sponsor.CAMPX__Event__c);
            if (sponsor.CAMPX__Status__c == 'Accepted' && oldSponsor.CAMPX__Status__c != 'Accepted' && sponsor.CAMPX__Event__c == null){
                sponsor.addError('A Sponsor must be associated with an event before being Accepted.');
            }
        }
    }

    public static void afterUpdateHandler(List<CAMPX__Sponsor__c> newSponsors, Map<Id, CAMPX__Sponsor__c> oldSponsorsMap){
        updateGrossRevenue(newSponsors);
    }
}