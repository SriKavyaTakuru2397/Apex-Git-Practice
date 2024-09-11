@IsTest
public class getHttpCalloutMockTask implements HttpCalloutMock {
    
    public HTTPResponse respond(HTTPRequest req) {
       
        HttpResponse res = new HttpResponse();
        
        res.setStatusCode(200);

        
        String jsonResponse = '[{"name": "Test Name", "id": "12345", "data": "Test Data"}]';
        res.setBody(jsonResponse);

        return res;
    }
}