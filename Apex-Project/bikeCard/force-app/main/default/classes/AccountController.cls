public with sharing class AccountController {
    @AuraEnabled
    public static Id createAccount(String accountName, String phone, Decimal annualRevenue) {
        Account acc = new Account();
        acc.Name = accountName;
        acc.Phone = phone;
        acc.AnnualRevenue = annualRevenue;
        insert acc;
        return acc.Id;
    }
}
