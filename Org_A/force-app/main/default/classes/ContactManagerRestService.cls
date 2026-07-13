@RestResource(urlMapping='/ContactManager/*')
global class ContactManagerRestService {
    @HttpGet
    global static List<Contact> getContacts() {
        RestRequest req = RestContext.request;
        String firstName = req.params.get('firstName');
        String lastName = req.params.get('lastName');
        
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
        
        List<Contact> contactsToDelete = [SELECT Id 
                                          FROM Contact 
                                          WHERE FirstName = :firstName AND LastName = :lastName];
        if (!contactsToDelete.isEmpty()) {
            delete contactsToDelete;
        }
    }
    
    @HttpPost
    global static void createContact(String firstName, String lastName) {
        Contact newContact = new Contact(
            FirstName = firstName,
            LastName = lastName);
        insert newContact;
    }
}