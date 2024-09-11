@isTest
private class RestApiTaskTest {
  @isTest
  static void getDataTest() {
    Test.setMock(HttpCalloutMock.class, new RestApiTaskMock());

    HttpResponse response = new RestApiTask().getData();

    String contentType = response.getHeader('Content-Type');
    Assert.isTrue(contentType == 'application/json');
    String actualValue = response.getBody();
    System.debug(response.getBody());
    String expectedValue = '[{"id": "1","name": "Google Pixel 6 Pro","data": {"color": "Cloudy White","capacity": "128 GB"}},{"id": "2","name": "Apple iPhone 12 Mini, 256GB, Blue","data": null}]';
    Assert.areEqual(expectedValue, actualValue);
    Assert.areEqual(200, response.getStatusCode());
  }
  @isTest
  static void postDataTest() {
    Test.setMock(HttpCalloutMock.class, new RestApiTaskMock());
    HttpResponse response = new RestApiTask().postData();
    System.debug(response);
    String contentType = response.getHeader('Content-Type');
    Assert.isTrue(contentType == 'application/json');
    String actualValue = response.getBody();
    String expectedValue = '{"id": "14","name": "Apple iPad","data": {"generation": "4rd","price": 1200}}';
    Assert.areEqual(expectedValue, actualValue);
    Assert.areEqual(200, response.getStatusCode());
  }

  @isTest
  static void putDataTest() {
    Test.setMock(HttpCalloutMock.class, new RestApiTaskMock());
    HttpResponse response = new RestApiTask().putData();
    String contentType = response.getHeader('Content-Type');
    Assert.isTrue(contentType == 'application/json', 'Not True');
    String actualValue = response.getBody();
    String expectedValue = '{"model": {"generation": "5rd","price": 125}}';
    Assert.areEqual(expectedValue, actualValue);
    Assert.areEqual(200, response.getStatusCode());
  }
}