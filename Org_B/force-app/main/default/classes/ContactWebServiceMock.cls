@IsTest
global class ContactWebServiceMock implements HttpCalloutMock {
    
    private Integer statusCode = 200;
    private String body = '';
    
    global ContactWebServiceMock(Integer statusCode, String body) {
        this.statusCode = statusCode;
        this.body = body;
    }
    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        
        response.setStatusCode(this.statusCode);
        response.setBody(this.body);

        return response;
    }
}