#library('utils');

#import('dart:html');
#import('package:log4dart/Lib.dart');

/**
* Classe utilitaire pour les XMLHttpRequest.
*/
class XMLHttpRequests {
  static getXMLHttpRequest(String url, [Map<String, List<String>> headers, onSuccess(XMLHttpRequest request), onFail(XMLHttpRequest request)]){
    sendXMLHttpRequest('GET', url, null, headers, onSuccess, onFail);
  }
  
  static postXMLHttpRequest(String url, [data, Map<String, List<String>> headers, onSuccess(XMLHttpRequest request), onFail(XMLHttpRequest request)]){
    sendXMLHttpRequest('POST', url, data, headers, onSuccess, onFail);
  }
  
  static sendXMLHttpRequest(String method, String url, [data, Map<String, List<String>> headers, onSuccess(XMLHttpRequest request), onFail(XMLHttpRequest request), Logger logger]) {
    final request = buildXMLHttpRequest(method, url, headers, onResponse : (XMLHttpRequest request){
      if(logger != null){
        logger.info("${request.status} - $url - ${request.responseText}");
      }
      // Status 0 is for local XHR request.
      if (request.status == 200 || request.status == 0) {
        if(onSuccess != null){
          onSuccess(request);
        }
      } else if (onFail != null){
        onFail(request);
      }
    }); 

    if(logger != null){
      logger.info("$method - $url");
    }
    request.send(data);
  }
  
  static XMLHttpRequest buildXMLHttpRequest(String method, String url, [Map<String, List<String>> headers, onRequest(XMLHttpRequest request), onResponse(XMLHttpRequest response)]) {
    final request = new XMLHttpRequest();
    request.open(method, url);
    request.withCredentials = false;
    if(headers != null) {
      headers.forEach((key, values) => values.forEach((value) => request.setRequestHeader(key, value)));
    }
    
    if(onRequest != null){
      onRequest(request);
    }
    if(onResponse != null){
      request.on.readyStateChange.add((Event e) {
        if (request.readyState == XMLHttpRequest.DONE) {
          onResponse(request);
        }
      });
    }

    return request;
  }
}
