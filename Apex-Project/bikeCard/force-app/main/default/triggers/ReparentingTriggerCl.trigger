trigger ReparentingTriggerCl on Platform_Event_Task__e (after insert) {
 
    ReparentTriggerHandlerCl handler = new ReparentTriggerHandlerCl();
    handler.handleReparentingLogic(Trigger.New);

}


