public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account LIMIT 100]; 
    }

    @AuraEnabled
    public static Id createContact(String firstName, String lastName, Id accountId) {
        Contact con = new Contact();
        con.FirstName = firstName;
        con.LastName = lastName;
        if(accountId!=null){
        con.AccountId = accountId;
    }
        insert con;
        return con.Id;
    }
}
