public abstract class ReparentingHandlerHelper implements ReparentingHandlerInterface {
    
    @TestVisible
    protected Schema.SObjectField getFieldByObjectType(Schema.SObjectType sot) {
        // Define the mappings between SObject types and the relevant relationship fields
        Map<Schema.SObjectType, Schema.SObjectField> fieldMap = new Map<Schema.SObjectType, Schema.SObjectField>{
            Contact.SObjectType => Contact.AccountId,
            Employee__c.SObjectType => Employee__c.Account__c
        };
        
        return fieldMap.get(sot);
    }
}
