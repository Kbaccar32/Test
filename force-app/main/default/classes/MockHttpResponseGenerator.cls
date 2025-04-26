@isTest
public class MockHttpResponseGenerator implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
        // Create a mock HTTP response
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody('{"message": "Contacts synced successfully."}');
        response.setHeader('Content-Type', 'application/json');
        return response;
    }
}
