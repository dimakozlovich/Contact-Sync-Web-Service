@isTest
public class ContactManagerRestServiceTest {
    @isTest
    static void getContactsTest() {
        insert new Contact(FirstName = 'Test', LastName = 'Contact');
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/ContactManager/';
        req.httpMethod = 'GET';
        req.params.put('firstName', 'Test');
        req.params.put('lastName', 'Contact');
        
        RestContext.request = req;
        RestContext.response = new RestResponse();
        
        Test.startTest();
        List<Contact> results = ContactManagerRestService.getContacts();
        Test.stopTest();
        
        System.assertEquals(1, results.size());
    }
    
    @isTest
    static void deleteContactsTest() {
        insert new Contact(FirstName = 'Test', LastName = 'Contact');
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/ContactManager/';
        req.httpMethod = 'DELETE';
        req.params.put('firstName', 'Test');
        req.params.put('lastName', 'Contact');
        
        RestContext.request = req;
        
        Test.startTest();
        ContactManagerRestService.deleteContacts();
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM Contact WHERE FirstName = 'Test' AND LastName = 'Contact']);
    }
    
    @isTest
    static void createContactTest() {
        Test.startTest();
        ContactManagerRestService.createContact('Test', 'Contact');
        Test.stopTest();
        
        System.assertEquals(1, [SELECT count() FROM Contact WHERE FirstName = 'Test' AND LastName = 'Contact']);
    }
}