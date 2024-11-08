public class RelatedAccountObjectsSelection {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getRelatedObjectsById(Id accountId, String selectedObject) {

       
        List<FieldObjectRelation__mdt> metadata = [
            SELECT Field_Config__r.Label, Field_Config__r.Field_Api_Name__c 
            FROM FieldObjectRelation__mdt  
            WHERE Object_Config__r.Label = :selectedObject
        ];

      
        Map<String, Object> responseMap = new Map<String, Object>();

        Set<String> validColumns = new Set<String>();
        List<FieldObjectRelation__mdt> validMetadata = new List<FieldObjectRelation__mdt>();

        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap();

       
        for (FieldObjectRelation__mdt mdt : metadata) {
            String fieldApiName = mdt.Field_Config__r.Field_Api_Name__c.trim();
            System.debug('Checking Field: ' + fieldApiName);

            if (fieldMap.containsKey(fieldApiName)) {
                validColumns.add(fieldApiName); 
                validMetadata.add(mdt);  
                System.debug('Valid field: ' + fieldApiName);
            } else {
                System.debug('Invalid field ignored: ' + fieldApiName);
            }
        }

      
        if (!validColumns.isEmpty()) {
           
            responseMap.put('metadata', validMetadata); 

       
            String query = 'SELECT Id,' + String.join(validColumns, ',') + 
                           ' FROM ' + selectedObject + 
                           ' WHERE AccountId =: accountId ORDER BY LastModifiedDate DESC';
            System.debug('Generated Query: ' + query);

         
            List<SObject> relatedObjectRecords = Database.query(query);
            
            
            Map<Id, SObject> recordsMap = new Map<Id, SObject>();
            for (SObject record : relatedObjectRecords) {
                recordsMap.put(record.Id, record);  
            }

            
            responseMap.put('relatedObjectRecords', recordsMap);
        } else {
            System.debug('No valid fields found for query.');
        }

      
        return responseMap;  
    }
}
