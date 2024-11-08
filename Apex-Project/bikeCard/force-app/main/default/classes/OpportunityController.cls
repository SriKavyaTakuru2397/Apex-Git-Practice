public with sharing class OpportunityController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account LIMIT 100]; 
    }

    @AuraEnabled
    public static Id createOpportunity(String opportunityName, Date closeDate, String stage, Id accountId) {
        Opportunity opp = new Opportunity();
        opp.Name = opportunityName;
        opp.CloseDate = closeDate;
        opp.StageName = stage;
        opp.AccountId = accountId;
        insert opp;
        return opp.Id;
    }
}
