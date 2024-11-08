public class ReparentingHandlerFa {
    public static ReparentingHandlerInterface getHandler(String objectType) {
        if (objectType == 'Contact') {
            return new StandardObjectReparentingHandler();
        } else if (objectType == 'Employee__c') {
            return new CustomObjectReparentingHandler();
        } else {
          
            throw new IllegalArgumentException('Unsupported object type: ' + objectType);
        }
    }
}
       