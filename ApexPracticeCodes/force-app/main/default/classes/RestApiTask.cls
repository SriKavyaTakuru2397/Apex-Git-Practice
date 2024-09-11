public with sharing class RestApiTask {
  public HttpResponse getData() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://api.restful-api.dev/objects');
    request.setMethod('GET');
    HttpResponse response = http.send(request);
    // String name = '';
    List<Mobiles__c> mobiles = new List<Mobiles__c>();
    if (response.getStatusCode() == 200) {
      //   Map<String, Object> resultMap = (Map<String, Object>) JSON.deserializeUntyped(
      //     response.getBody()
      //   );
      //   List<Map<String, Object>> resultData = (List<Map<String, Object>>) resultMap.get(
      //     'data'
      //   );
      //   List<Map<String, Object>> result = (List<Map<String, Object>>) JSON.deserializeUntyped(
      //     response.getBody()
      //   );
      List<Object> result = (List<Object>) JSON.deserializeUntyped(
        response.getBody()
      );
      System.debug(result);
      for (Object obj : result) {
        Map<String, Object> mobile = (Map<String, Object>) obj;
        Mobiles__c mob = new Mobiles__c();
        if (obj instanceof Map<String, Object>) {
          System.debug(mobile);
          mob.Id__c = (String) mobile.get('id');
          mob.Name__c = (String) mobile.get('name');
        }
        Object dataObject = mobile.get('data');
        if (dataObject instanceof Map<String, Object>) {
          Map<String, Object> dataMap = (Map<String, Object>) dataObject;
          mob.Data__c = JSON.serialize(dataMap);
        } else {
          mob.Data__c = null;
        }
        // mob.Data__c = (String) mobile.get('data');
        mobiles.add(mob);
      }
      //   Map<String, Object> mobiles = (Map<String, Object>) result.get('data');
      //   System.debug(result);
      //   System.debug(mobiles);
      //   name = (String) result[Id];
    } else {
      System.debug('Failed to get info..');
    }
    if (!mobiles.isEmpty()) {
      insert mobiles;
    }
    return response;
  }
  public HttpResponse postData() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://api.restful-api.dev/objects');
    request.setMethod('POST');
    System.debug(request.getMethod());
    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
    String body = '{"id": "14","name": "Apple iPad","data": {"generation": "4rd","price": 1200}}';
    request.setBody(body);
    HttpResponse response = http.send(request);
    if (response.getStatusCode() == 200) {
      // List<Map<String, Object>> result = (List<Map<String, Object>>) JSON.deserializeUntyped(
      //   response.getBody()
      // );
      Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        response.getBody()
      );
      System.debug(result);
      //   mob.Id__c = (String) mobile.get('id');
      //   mob.Name__c = (String) mobile.get('name');
      //   Object dataObject = mobile.get('data');
      //   if (dataObject instanceof Map<String, Object>) {
      //     Map<String, Object> dataMap = (Map<String, Object>) dataObject;
      //     mob.Data__c = JSON.serialize(dataMap);
      //   } else {
      //     mob.Data__c = null;
      //   }
      // return result;
    } else {
      System.debug('Failed to post info..');
      //  return ;
    }
    return response;
  }
  public HttpResponse putData() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://api.restful-api.dev/objects/2');
    request.setMethod('PUT');
    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
    String body = '{"name": "Apple iPhone 15 Mini, 512GB, Blue","data": null}';
    request.setBody(body);
    HttpResponse response = http.send(request);
    System.debug(response);
    if (response.getStatusCode() == 200) {
      Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        response.getBody()
      );
    } else {
      System.debug('Put failed..');
    }
    return response;
  }
}