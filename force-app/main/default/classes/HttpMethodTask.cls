public class HttpMethodTask {
    public static HttpResponse GetHttpMethodTask() {
        
        Http http=new Http();
        HttpRequest request =new HttpRequest();
        request.setEndpoint('https://api.restful-api.dev/objects');
        request.setMethod('GET');
        HttpResponse response=Http.send(request);
        List<Object> result=new List<Object>();
        if(response.getStatusCode()==200){
           result=(List<Object>)JSON.deserializeUntyped(response.getBody());
           List<ExternalWebObj__c> recordsToInsert = new List<ExternalWebObj__c>();
                for (Object eachObj : result) {
                    Map<String, Object> objMap = (Map<String, Object>) eachObj;
                    ExternalWebObj__c obj = new ExternalWebObj__c(
                        NameEx__c = (String) objMap.get('name'),
                    //    DataEx__c = (String) objMap.get('data'),
                        IdEx__c = (String) objMap.get('Id')
                   
                    );
                    recordsToInsert.add(obj);
                }
                if(!recordsToInsert.isEmpty()) {
                    insert recordsToInsert;
                }
            System.debug(result);
        }
            
            for (Object obj : result) {
                Map<String, Object> objMap = (Map<String, Object>) obj; 

                System.debug('Object: ' + objMap);
                for(String key : objMap.keySet()){
                   
                    if (key.Equals('data')) {
                        System.debug('Value: ' + objMap.get(key));
                    }
                    
                }
              String name = (String) objMap.get('name');
              String id = (String) objMap.get('id');
              System.debug('Name: ' + name);
              System.debug('ID: ' + id);
     }
       return response;
     
   
}

    public static HttpResponse postHttpMethodTask (){
       

            Http http=new Http();
            HttpRequest request =new HttpRequest();
    
           
            request.setEndpoint('https://api.restful-api.dev/objects');
            request.setMethod('POST');
            request.setHeader('Content-Type','application/json;charset=UTF-8');
            request.setBody('{"name":"Google pixel 999"}');
            
            String payload=JSON.serialize(new Map<String,Object>{'name'=>'Google pixel 999'});
            //request.setBody(payload);
            HttpResponse response=Http.send(request);
    
            if(response.getStatusCode()!=200){
                System.debug('Request has been not successfully!'+response.getStatusCode());
                request.setBody(payload);
               // Map<String,Object> result=(Map<String,Object>) JSON.deserializeUntyped(response.getBody());
        }
        else{
            System.debug('Request has been successfully done'+response.getStatusCode());
        }
            
         
    return response;
    }
    public static HttpResponse putHttpMethodTask() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        
        String objectId = '7'; 
        String newName = 'Updated Name'; 
        String newData = 'Some New Data';  
        String newType = 'New Type';       
        
      
        String endpoint = 'https://api.restful-api.dev/objects/' + objectId;
        request.setEndpoint(endpoint);
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        
        Map<String, Object> payloadMap = new Map<String, Object>{
            'name' => newName,
            'data' => newData,
            'type' => newType,
            'id'   => objectId 
        };
        
        
        String payload = JSON.serialize(payloadMap);
        request.setBody(payload);
       
        HttpResponse response = http.send(request);
        
       
        if (response.getStatusCode() == 200) {
            System.debug('PUT request successful: ' + response.getStatusCode());
        } else {
            System.debug('Failed PUT request: ' + response.getStatusCode() + ', ' + response.getBody());
        }
        
        return response;
    }
    
    public static HttpResponse patchHttpMethodTask() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
    
       
        String objectId = '7'; 
        String newName = 'Updated Name'; 
    
      
        String endpoint = 'https://api.restful-api.dev/objects/' + objectId;
        request.setEndpoint(endpoint);
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
    
       
        String payload = JSON.serialize(new Map<String, Object>{'name' => newName});
        request.setBody(payload);
    
        
        HttpResponse response = http.send(request);
    
        
        if (response.getStatusCode() == 200) {
            System.debug('PUT request successful: ' + response.getStatusCode());
        } else {
            System.debug('Failed PUT request: ' + response.getStatusCode() + ', ' + response.getBody());
        }
    
        return response;
    }
    public static HttpResponse deleteHttpMethodTask() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        
        String objectId = '7'; 
        
        
        String endpoint = 'https://api.restful-api.dev/objects/' + objectId;
        request.setEndpoint(endpoint);
        request.setMethod('DELETE'); 
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        
        HttpResponse response = http.send(request);
        
        
        if (response.getStatusCode() == 200) {
            System.debug('DELETE request successful: ' + response.getStatusCode());
        } else {
            System.debug('Failed DELETE request: ' + response.getStatusCode() + ', ' + response.getBody());
        }
        
        return response;
    }
    
}