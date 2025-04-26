public class ContactHandler {
    @future(callout=true)
    public static void syncContactsToAPI(Set<Id> contactIds) {
        // Query the Contact records using the passed IDs
        List<Contact> contactsToSync = [SELECT Id, Is_Active__c FROM Contact WHERE Id IN :contactIds];

        // Prepare the payload for the API call
        List<Map<String, Object>> payload = new List<Map<String, Object>>();
        for (Contact contact : contactsToSync) {
            payload.add(new Map<String, Object>{
                'id' => contact.Id,
                'is_active' => contact.Is_Active__c
            });
        }

        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:ContactSyncAPI'); // Using Named Credential
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSON.serialize(payload));

        Http http = new Http();
        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                System.debug('Contacts synced successfully.');
            } else {
                System.debug('Error syncing contacts: ' + response.getStatusCode() + ' ' + response.getBody());
            }
        } catch (Exception e) {
            System.debug('Exception while syncing contacts: ' + e.getMessage());
        }
    }
}
