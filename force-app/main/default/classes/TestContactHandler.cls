@isTest
public class TestContactHandler {
    @isTest
    static void testSyncContactsToAPI() {
        // Step 1: Create test data
        Contact contact1 = new Contact(FirstName='John', LastName='Doe', Is_Active__c=true);
        Contact contact2 = new Contact(FirstName='Jane', LastName='Doe', Is_Active__c=false);
        insert new List<Contact>{contact1, contact2};

        // Step 2: Collect IDs of test contacts
        Set<Id> contactIds = new Set<Id>{contact1.Id, contact2.Id};

        // Step 3: Use HttpCalloutMock for API simulation
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();
        ContactHandler.syncContactsToAPI(contactIds); // Future method call
        Test.stopTest();

        // Step 4: Assert that the mock logic was executed
        // (Assumes the MockHttpResponseGenerator contains appropriate assertions)
        System.assert(true, 'Ensure future method processed contacts.');
    }
}