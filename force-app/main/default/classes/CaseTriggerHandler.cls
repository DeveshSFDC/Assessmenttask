public class CaseTriggerHandler {
    public static void handleAfterInsertOrUpdate(List<Case> newCases) {
        List<Sqx_Nonconformance__c> nonconformanceRecordsToCreate = new List<Sqx_Nonconformance__c>();
        
        for (Case c : newCases) {
            if (c.Type == 'Problem') {
                if (!nonconformanceExistsForCase(c.Id)) {
                    nonconformanceRecordsToCreate.add(createNonconformanceRecord(c));
                    //test
                }
            }
        }
        
        if (!nonconformanceRecordsToCreate.isEmpty()) {
            insert nonconformanceRecordsToCreate;
        }
    }
    
    private static boolean nonconformanceExistsForCase(Id caseId) {
        return [SELECT COUNT() FROM Sqx_Nonconformance__c WHERE SQX_NC_Reference__c = :caseId] > 0;
    }
    
    private static Sqx_Nonconformance__c createNonconformanceRecord(Case c) {
        return new Sqx_Nonconformance__c(
            SQX_NC_Reference__c = c.Id ,
            Priority__c = c.Priority,
            Title__c = c.Subject,
            Description__c =c.Description,
            QMS_Reference_Number__c = c.CaseNumber
            
        );
    }
    
}