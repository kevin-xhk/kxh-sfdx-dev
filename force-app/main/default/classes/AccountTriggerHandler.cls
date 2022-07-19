/**
 * Created by kxhakaj on 7/15/2022.
 */

public with sharing class AccountTriggerHandler {

    // dispatch

    public static void handleAfterInsert(Map<Id, Account> newAcc) {
        appendRandomContacts(newAcc);
    }


    // logic

    private static Account appendRandomContacts(Map<Id, Account> newAcc) {
        Integer num = 5;
        getRandomContacts(num);

        return null; //to-be-changed
    }


    // helper
    private static List<Contact> getRandomContacts(Integer num) {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://randomuser.me/api?nat=gb&results=' + num);

        Http http = new Http();
        HttpResponse res;
        
        try {
            res = http.send(req);
            System.debug('HTTP response: ' + res.getBody());
        } catch (System.CalloutException e) {
            System.debug('ERROR: http.send(req) - ' + e);
        }

        return null;
    }
}