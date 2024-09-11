@isTest
public class RestApiTaskMock implements HttpCalloutMock {
  public HttpResponse respond(HttpRequest request) {
    HttpResponse response = new HttpResponse();
    response.setHeader('Content-Type', 'application/json');
    if (request.getMethod() == 'POST') {
      response.setBody(
        '{"id": "14","name": "Apple iPad","data": {"generation": "4rd","price": 1200}}'
      );
    } else if (request.getMethod() == 'GET') {
      response.setBody(
        '[{"id": "1","name": "Google Pixel 6 Pro","data": {"color": "Cloudy White","capacity": "128 GB"}},{"id": "2","name": "Apple iPhone 12 Mini, 256GB, Blue","data": null}]'
      );
    } else if (request.getMethod() == 'PUT') {
      response.setBody('{"model": {"generation": "5rd","price": 125}}');
    }

    response.setStatusCode(200);
    return response;
  }
}