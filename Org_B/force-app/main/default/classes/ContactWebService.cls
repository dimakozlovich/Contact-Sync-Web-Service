
public class ContactWebService {

    private static final String ENDPOINT = 'callout:Org_A_named_credentials/services/apexrest/ContactManager';

    public List<Contact> getContact(String firstName, String lastName) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
        String queryParams = '?firstName=' + EncodingUtil.urlEncode(firstName, 'UTF-8') + 
                             '&lastName=' + EncodingUtil.urlEncode(lastName, 'UTF-8');
        
        req.setEndpoint(ENDPOINT + queryParams);
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json');
        
        try {
            HttpResponse res = http.send(req);
            
            if (res.getStatusCode() == 200 && String.isNotBlank(res.getBody())) {
                return (List<Contact>) JSON.deserialize(res.getBody(), List<Contact>.class);
            }
        } catch (System.Exception e) {
            System.debug(e.getMessage());
        }
        
        return new List<Contact>(); 
    }
    
    public void deleteContact(String firstName, String lastName) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
        String queryParams = '?firstName=' + EncodingUtil.urlEncode(firstName, 'UTF-8') + 
                             '&lastName=' + EncodingUtil.urlEncode(lastName, 'UTF-8');
        
        req.setEndpoint(ENDPOINT + queryParams);
        req.setMethod('DELETE');
        
        try {
            HttpResponse res = http.send(req);
            System.debug('DELETE Статус: ' + res.getStatusCode());
        } catch (System.Exception e) {
            System.debug(e.getMessage());
        }
    }
    
    public void addContact(String firstName, String lastName) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint(ENDPOINT);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        
        Map<String, String> requestBody = new Map<String, String>{
            'firstName' => firstName,
            'lastName' => lastName
        };
        req.setBody(JSON.serialize(requestBody));
        
        try {
            HttpResponse res = http.send(req);
            System.debug('POST Статус: ' + res.getStatusCode());
        } catch (System.Exception e) {
            System.debug(e.getMessage());
        }
    }
}