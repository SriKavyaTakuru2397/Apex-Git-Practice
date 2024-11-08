public class AccountContactTable {
  
  @AuraEnabled(cacheable=true)
  public static List<CustomMetaDataCl> getContactsByAccountId(Id accountId) {
      List<contactsCustomDataTable__mdt> metadata = [
          SELECT Column__c, Column_Api_Name__c
          FROM contactsCustomDataTable__mdt
          
      ];
      
      List<CustomMetaDataCl> conList = new List<CustomMetaDataCl>();
      Set<String> columns = new Set<String>();
      
      for (contactsCustomDataTable__mdt mdt : metadata) {
          columns.add(mdt.Column_Api_Name__c);
        }
        conList.add(new CustomMetaDataCl(metadata));

      System.debug('conList----' + conList);

      String query = 'SELECT Id,' + String.join(columns, ',') +
                     ' FROM Contact WHERE AccountId =: accountId ORDER BY LastModifiedDate DESC';
      
      System.debug(String.join(columns, ','));
      
      List<Contact> contacts = Database.query(query);
      System.debug(contacts);
      
      conList.add(new CustomMetaDataCl(contacts));
      
      return conList;
  }

//   @AuraEnabled(cacheable=true)
//   public static List<contactsCustomDataTable__mdt> getColumn() {
//       return [
//           SELECT Column__c, Column_Api_Name__c
//           FROM contactsCustomDataTable__mdt
//       ];
//   }
  
}
