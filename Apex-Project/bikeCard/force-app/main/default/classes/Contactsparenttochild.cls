public class Contactsparenttochild {
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactptoc() {
        List<Contact> conList = [Select Id, Name,Email,Phone From Contact];
        System.debug('conList'+conList);
        return conList;

    }

 
}