trigger CaseTrigger on Case (after insert, after update) {
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        CaseTriggerHandler.handleAfterInsertOrUpdate(Trigger.new);
    }

}