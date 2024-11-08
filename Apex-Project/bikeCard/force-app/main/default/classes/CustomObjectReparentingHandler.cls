public class CustomObjectReparentingHandler extends ReparentingHandlerHelper {
    public void handleReparentingLogic(List<Platform_Event_Task__e> events) {
        for (Platform_Event_Task__e event : events) {
            List<Id> childObjIds = (List<Id>)JSON.deserializeUntyped(event.childObjId__c);
            Id newParentId = event.ParentObjId__c;

          
            Schema.SObjectField relationshipField = getFieldByObjectType(Employee__c.SObjectType);

            
            Map<Id, SObject> customObjectsToUpdateMap = new Map<Id, SObject>();

            for (Id customObjId : childObjIds) {
                SObject customObj = Schema.getGlobalDescribe().get('Employee__c').newSObject(customObjId);
                customObjectsToUpdateMap.put(customObjId, customObj);
            }

           
            for (SObject customObj : customObjectsToUpdateMap.values()) {
                customObj.put(relationshipField.getDescribe().getName(), newParentId);
            }

           
            if (!customObjectsToUpdateMap.isEmpty()) {
                update customObjectsToUpdateMap.values();
            }
        }
    }
}
