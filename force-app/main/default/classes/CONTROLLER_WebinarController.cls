/**
 * Created by kxhakaj on 7/8/2022.
 */

//public with sharing class CONTROLLER_WebinarController {
//
//    @AuraEnabled
//    public static List<Webinar__c> getWebinars(Integer price) {
//        return [
//                SELECT Id
//                FROM Webinar__c
//                WHERE Cost__c > :price
//                    AND Approval_Status__c = 'Pending'
//                ORDER BY CreatedDate DESC
//        ]; //todo
//    }
//
//    @AuraEnabled
//    public static void setWebinarApprovalStatus(String approvalStatus) {
//
//    }
//}


// Einstein, July 11th
public with sharing class CONTROLLER_WebinarController {

    @AuraEnabled
    public static Webinar__c[] getPendingWebinars(String queryLimit) {
        return [
                SELECT Name, Description__c, Cost__c, Status__c, Approval_Status__c
                FROM Webinar__c
                WHERE Approval_Status__c = 'Pending'
                LIMIT :Integer.valueOf(queryLimit)
        ];
    }

    @AuraEnabled
    public static void changeWebinarStatus(Id id, String newStatus) {
        System.debug('apex, changeWebinarStatus: id- ' + id + ' newStatus- ' + newStatus);
        Webinar__c w = [SELECT Id, Approval_Status__c FROM Webinar__c WHERE Id = :id LIMIT 1];
        w.Approval_Status__c = newStatus;
        update w;
    }

    @AuraEnabled
    public static List<Webinar__c> getWebinarsByFilters(String type, String status) {
        return [
                SELECT Name, Description__c, Cost__c, Type__c, Status__c, Approval_Status__c
                FROM Webinar__c
                WHERE Type__c LIKE :type AND Status__c LIKE :status
        ];
    }

    @AuraEnabled
    public static Webinar__c saveWebinar(Webinar__c webinar) {
        Database.insert(webinar, true);

        return webinar;
    }
}