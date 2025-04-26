@isTest
public class TestUpdateMissionStatusTrigger {
    @isTest
    static void testTriggerFunctionality() {
        Account acc9 = new Account(Name='Test Account 1', Mission_Status__c='active');
        Account acc1 = new Account(Name='Test Account 1', Mission_Status__c='active');
        Account acc2 = new Account(Name='Test Account 2', Mission_Status__c='active');
        insert acc1;
        insert acc2;

        Contact contact = new Contact(FirstName='John', LastName='Doe', Is_Active__c=true,AccountId=acc1.Id);
        insert contact;

       // AccountContactRelation acr1 = new AccountContactRelation(AccountId=acc1.Id, ContactId=contact.Id);
       // insert acr1;

        acc1.Mission_Status__c = 'canceled';
        update new List<Account>{acc1};

        Account updatedAcc1 = [SELECT Mission_Canceled_Date__c FROM Account WHERE Id = :acc1.Id];
        System.assert(updatedAcc1.Mission_Canceled_Date__c != null);

        Contact updatedContact = [SELECT Is_Active__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(false, updatedContact.Is_Active__c);
    }
}
