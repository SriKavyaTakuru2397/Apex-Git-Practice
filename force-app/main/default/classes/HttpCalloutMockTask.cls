@isTest
global class HttpCalloutMockTask implements HttpCalloutMock{
    //Mock body
    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"id":"13","name":"Apple iPad Air","data":{"Generation":"4th","Price":"519.99","Capacity":"256 GB"}}]');
        response.setStatusCode(200);
        return response;
    

    }
}