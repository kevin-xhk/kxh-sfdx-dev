/**
 * Created by kxhakaj on 7/14/2022.
 */

public with sharing class BatchWebinarReminderContacts implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext param1) {
        Datetime currentTime = System.Datetime.now();
        //query related contacts
        return Database.getQueryLocator([
                SELECT Name, Related_Contact__c, Webinar__r.Name, Related_Contact__r.Email
                FROM Webinar_Team_Member__c
                WHERE Webinar__r.Start_Time__c = TOMORROW
                AND Related_Contact__c != NULL
        ]);
    }

    public void execute(Database.BatchableContext param1, List<Webinar_Team_Member__c> webinars) {
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        for (Webinar_Team_Member__c w : webinars) {

            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses = new List<String>{ w.Related_Contact__r.Email };
            message.subject = 'Webinar reminder';
            message.plainTextBody = 'Your webinar ' + w.Webinar__r.Name + ' is staring tomorrow';
            messages.add(message);
        }

        Messaging.sendEmail(messages);

    }

//    public void execute(Database.BatchableContext param1, List<Webinar_Team_Member__c> webinarTeamMembers) {
//
//        List<FeedItem> emailList = new List<FeedItem>();
//        for (Webinar_Team_Member__c wtm : webinarTeamMembers) {
//            emailList.add(wtm.Related_Contact__r.Email);
//        }
//
//
//
////
////        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
////        email.toaddresses = webinarTeamMembers;
////        email.subject ='list not modified';
////        String msg = 'Whatevs';
////
////        email.setHtmlBody(msg);
////        emailList.add(email);
////        if (emailList.size() > 0) {
////            //Sent email
////            Messaging.sendEmail(emailList);
////            System.debug('Email is sent Successfully.');
////        }
//
////        if (!emailList.isEmpty()) {
////            insert emailList;
////        }
//    }

    public void finish(Database.BatchableContext param1) {
        System.debug('task finished');
    }
}