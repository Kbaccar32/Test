trigger UpdateMissionStatusTrigger on Account (after update) {
    List<Account> accountsToProcess = new List<Account>();
    for (Account acc : Trigger.new) {
        if (acc.Mission_Status__c == 'canceled' && Trigger.oldMap.get(acc.Id).Mission_Status__c != 'canceled') {
            accountsToProcess.add(new Account(Mission_Canceled_Date__c = Date.today(),Id=acc.Id,Mission_Status__c ='canceled'));
        }
    }
    if (!accountsToProcess.isEmpty()) {
        update accountsToProcess;
        AccountHandler.handleMissionCanceled(accountsToProcess);
    }
}