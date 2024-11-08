public class CustomMetaDataCl {
    // @AuraEnabled
    // public String columnName;
    // @AuraEnabled
    // public String colApiName;
    @AuraEnabled
    public List<contactsCustomDataTable__mdt> metadata;
    @AuraEnabled
   public List<Contact> contacts;

  
 
   public CustomMetaDataCl(List<contactsCustomDataTable__mdt> metadata) {
    this.metadata = metadata;
}
    
 
    public CustomMetaDataCl(List<Contact> contacts) {
        this.contacts = contacts;
    }
}

   
