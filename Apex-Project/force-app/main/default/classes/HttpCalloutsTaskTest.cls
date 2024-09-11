@isTest
private class HttpCalloutsTaskTest {

    @isTest
    static void myUnitPostTest() {
        Test.setMock(HttpCalloutMock.class,new HttpCalloutMockTask());
        HttpResponse response=HttpMethodTask.postHttpMethodTask();

        String contentType = response.getHeader('Content-Type');
        System.Assert.isTrue(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue='[{"id":"13","name":"Apple iPad Air","data":{"Generation":"4th","Price":"519.99","Capacity":"256 GB"}}]';

        Assert.areEqual(expectedValue, actualValue);
    Assert.areEqual(200, response.getStatusCode());
      
    }

    @isTest
    static void myUnitGetTest() {
        Test.setMock(HttpCalloutMock.class,new getHttpCalloutMockTask());
        HttpResponse response=HttpMethodTask.GetHttpMethodTask();
        String actualValue = response.getBody();
        String expectedValue='[{"name": "Test Name", "id": "12345", "data": "Test Data"}]';

        Assert.areEqual(expectedValue, actualValue);


        

        
        System.assertEquals(200, response.getStatusCode());


      
        // List<ExternalWebObj__c> records = [SELECT NameEx__c, IdEx__c FROM ExternalWebObj__c WHERE IdEx__c = '12345'];
        // // System.assertEquals(1, records.size());
        // System.assertEquals('Test Name', records[0].NameEx__c);
        // System.assertEquals('12345', records[0].IdEx__c);
      
    }
}