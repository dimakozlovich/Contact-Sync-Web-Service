@IsTest
public class ContactWebServiceTest {
    @isTest
    static void testGetContactSuccess() {
        String mockJsonResponse = '[{"FirstName": "Integration", "LastName": "TestUser"}]';
        
        Test.setMock(HttpCalloutMock.class, new ContactWebServiceMock(200, mockJsonResponse));
        
        ContactWebService service = new ContactWebService();
        
        Test.startTest();
        List<Contact> results = service.getContact('Integration', 'TestUser');
        Test.stopTest();
        
        System.assertEquals(1, results.size(), 'Must have one contact');
    }

    @isTest
    static void testGetContactServerError() {
        Test.setMock(HttpCalloutMock.class, new ContactWebServiceMock(500, 'Internal Server Error'));
        
        ContactWebService service = new ContactWebService();
        
        Test.startTest();
        List<Contact> results = service.getContact('Integration', 'TestUser');
        Test.stopTest();
        
        System.assertEquals(0, results.size(), 'Response should has empty list');
    }

    @isTest
    static void testAddContactSuccess() {
        Test.setMock(HttpCalloutMock.class, new ContactWebServiceMock(201, '{"status": "success"}'));
        
        ContactWebService service = new ContactWebService();
        
        Test.startTest();
        service.addContact('Integration', 'TestUser'); 
        Test.stopTest();
    }

    @isTest
    static void testDeleteContactSuccess() {
        Test.setMock(HttpCalloutMock.class, new ContactWebServiceMock(200, '{"status": "deleted"}'));
        
        ContactWebService service = new ContactWebService();
        
        Test.startTest();
        service.deleteContact('Integration', 'TestUser');
        Test.stopTest();
        
    }
}
