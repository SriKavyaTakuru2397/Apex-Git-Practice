public class StandardObjectReparentingHandler extends ReparentingHandlerHelper {
    public void handleReparentingLogic(List<Platform_Event_Task__e> events) {
        for (Platform_Event_Task__e event : events) {
            // Check if childObjId__c is non-null and deserializes correctly
            List<Id> childObjIds;
            try {
                childObjIds = (List<Id>) JSON.deserializeUntyped(event.childObjId__c);
            } catch (Exception e) {
                System.debug('Skipping event due to invalid childObjId__c format: ' + event.childObjId__c);
                continue;
            }

            if (childObjIds == null || childObjIds.isEmpty()) {
                System.debug('Skipping event due to empty or null childObjIds');
                continue;
            }

            Id newParentId = event.ParentObjId__c;

            // Get the relationship field for Contact object
            Schema.SObjectField relationshipField = getFieldByObjectType(Contact.SObjectType);
            String relationshipFieldName = relationshipField.getDescribe().getName();

            // Prepare map for valid contact records to update
            Map<Id, SObject> contactsToUpdateMap = new Map<Id, SObject>();

            for (Id contactId : childObjIds) {
                // Validate that contactId is a valid Salesforce ID format
                if (!isValidSalesforceId(contactId)) {
                    System.debug('Skipping invalid contact ID: ' + contactId);
                    continue;
                }
                
                // Create contact record and set parent ID
                SObject contact = Schema.getGlobalDescribe().get('Contact').newSObject(contactId);
                contact.put(relationshipFieldName, newParentId);
                contactsToUpdateMap.put(contactId, contact);
            }

            // Update contacts if map is not empty
            if (!contactsToUpdateMap.isEmpty()) {
                update contactsToUpdateMap.values();
            }
        }
    }

    // Helper method to validate a Salesforce ID
    private Boolean isValidSalesforceId(Id id) {
        // Salesforce IDs are either 15 or 18 characters and alphanumeric
        String idString = String.valueOf(id);
        Pattern p = Pattern.compile('^[a-zA-Z0-9]{15,18}$');
        Matcher m = p.matcher(idString);
        return m.matches();
    }
    
}
