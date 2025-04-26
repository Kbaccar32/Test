public class AccountHandler {
    public static void handleMissionCanceled(List<Account> accounts) {
        Map<Id, Boolean> contactStatusMap = new Map<Id, Boolean>();
        List<Contact> contactsToUpdate = new List<Contact>();

        for (Account acc : accounts) {
            for (AccountContactRelation acr : [SELECT ContactId FROM AccountContactRelation WHERE AccountId = :acc.Id]) {
                contactStatusMap.put(acr.ContactId, true);
            }
        }

        for (Id contactId : contactStatusMap.keySet()) {
            Boolean allCanceled = true;
            for (AccountContactRelation acr : [SELECT Account.Mission_Status__c FROM AccountContactRelation WHERE ContactId = :contactId]) {
                if (acr.Account.Mission_Status__c != 'canceled') {
                    allCanceled = false;
                    break;
                }
            }
            if (allCanceled) {
                Contact contact = new Contact(Id = contactId, Is_Active__c = false);
                contactsToUpdate.add(contact);
            }
        }

        if (!contactsToUpdate.isEmpty()) {
            // Update the contacts first
            update contactsToUpdate;
        
            // Collect the IDs of the updated contacts
            Set<Id> contactIdsToSync = new Set<Id>();
            for (Contact contact : contactsToUpdate) {
                contactIdsToSync.add(contact.Id);
            }
        
            // Call the future method using a Set<Id>
            ContactHandler.syncContactsToAPI(contactIdsToSync);
        }
    }
}
