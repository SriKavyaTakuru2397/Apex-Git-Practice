trigger BearAlertTopicAssignmentTrigger on TopicAssignment (after insert) {
   
    Set<Id> feedIds = new Set<Id>();
    for (TopicAssignment ta : Trigger.new){
        if (ta.EntityId.getSObjectType().getDescribe().getName().equals('FeedItem')) {
            feedIds.add(ta.EntityId);
        }
    }
    
    Map<Id,FeedItem> feedItems = new Map<Id,FeedItem>([SELECT Body FROM FeedItem WHERE Id IN :feedIds]);
   
    List<String> messages = new List<String>();
    for (TopicAssignment ta : [SELECT Id, EntityId, Topic.Name FROM TopicAssignment WHERE Id IN :Trigger.new AND Topic.Name = 'BearAlert']) {
        messages.add(feedItems.get(ta.EntityId).body.stripHtmlTags().abbreviate(255));
    }
  
    List<Notification__e> notifications = new List<Notification__e>();
    for (String message: messages) {
        notifications.add(new Notification__e(Message__c = message));
    }
    List<Database.SaveResult> results = EventBus.publish(notifications);
   
    for (Database.SaveResult result : results) {
        if (!result.isSuccess()) {
            for (Database.Error error : result.getErrors()) {
                System.debug('Error returned: ' + error.getStatusCode() +' - '+ error.getMessage());
            }
        }
    }
}