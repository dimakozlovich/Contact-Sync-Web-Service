@RestResource(urlMapping='/ContactManager/*')
global with sharing class ContactManagerRestService {
    @HttpGet
    global static List<Contact> getContacts() {
        RestRequest req = RestContext.request;
        String firstName = req.params.get('firstName');
        String lastName = req.params.get('lastName');
        
        if (String.isBlank(firstName) || String.isBlank(lasstName)) {
            throw new NullPointerException('First name and last name are required');
        }

        List<Contact> contacts = [SELECT Id, FirstName, LastName 
                                  FROM Contact 
                                  WHERE FirstName = :firstName AND LastName = :lastName];
        return contacts;
    }
    
    @HttpDelete
    global static void deleteContacts() {
        RestRequest req = RestContext.request;
        String firstName = req.params.get('firstName');
        String lastName = req.params.get('lastName');

        if(String.isBlank(firstName) || String.isBlank(lastName)) {
            throw new NullPointerException('First name and last name are required');
        }
        
        List<Contact> contactsToDelete = [SELECT Id 
                                          FROM Contact 
                                          WHERE FirstName = :firstName AND LastName = :lastName];
        if (!contactsToDelete.isEmpty()) {
            delete contactsToDelete;
        }
    }
    
    @HttpPost
    global static void createContact(String firstName, String lastName) {

        if(String.isBlank(lastName)) {
            RestContext.response.statusCode = 400;
            return;
        }

        Contact newContact = new Contact(FirstName = firstName, 
                                         LastName = lastName);
        insert newContact;
    }
}