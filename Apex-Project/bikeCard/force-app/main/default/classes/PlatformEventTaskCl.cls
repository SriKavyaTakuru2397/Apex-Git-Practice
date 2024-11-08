public class PlatformEventTaskCl {
    public static void publishPlatformEventTask() {
       
        List<String> childIdsList = new List<String>();
        childIdsList.add('003NS00000Cf95TYAR');
        childIdsList.add('003NS00000Cf95KYAR');
        childIdsList.add('003NS00000FD9w5YAD');
        
        String childIdsJson = JSON.serialize(childIdsList);
        
        Platform_Event_Task__e event = new Platform_Event_Task__e(
            parentObjId__c = '001NS00000QvH3qYAF', 
            childObjId__c = childIdsJson,
             className__c = 'StandardObjectReparentingHandler'
        );
        
        System.debug(event);
        
        // Correctly assign the result of EventBus.publish to a List<Database.SaveResult>
        List<Database.SaveResult> results = EventBus.publish(new List<Platform_Event_Task__e>{event});
        for (Database.SaveResult result : results) {
            if (result.isSuccess()) {
                System.debug('Successfully published event.');
            } else {
                for (Database.Error err : result.getErrors()) {
                    System.debug('Error returned: ' + err.getStatusCode() + ' - ' + err.getMessage());
                }
            }
        }
    }
}
