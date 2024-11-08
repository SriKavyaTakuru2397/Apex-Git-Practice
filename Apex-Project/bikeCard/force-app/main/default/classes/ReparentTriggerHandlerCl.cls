public class ReparentTriggerHandlerCl {
    public void handleReparentingLogic(List<Platform_Event_Task__e> events) {
       for (Platform_Event_Task__e event : events) {
           String objectType = event.className__c;

           
           ReparentingHandlerInterface handler = ReparentingHandlerFa.getHandler(objectType);

          
           handler.handleReparentingLogic(events);
        }
        System.debug(events);
    }
}


