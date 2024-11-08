public class WrapperClass {
    @AuraEnabled
    public List<FieldObjectRelation__mdt> metadata;
    
    @AuraEnabled
    public List<SObject> relatedObjectRecords;

   
    public WrapperClass(List<FieldObjectRelation__mdt> metadata, List<SObject> relatedObjectRecords) {
        this.metadata = metadata;
        this.relatedObjectRecords = relatedObjectRecords;
    }
    
  
}
