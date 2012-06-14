#library('utils');

#import('dart:html');
#import('package:log4dart/Lib.dart');

class XMLHttpRequests {
  static getXMLHttpRequest(String url, [onSuccess(XMLHttpRequest request), onFail(XMLHttpRequest request)]){
    sendXMLHttpRequest('GET', url, null, onSuccess, onFail);
  }
  
  static postXMLHttpRequest(String url, [data, onSuccess(XMLHttpRequest request), onFail(XMLHttpRequest request)]){
    sendXMLHttpRequest('POST', url, data, onSuccess, onFail);
  }
  
  static sendXMLHttpRequest(String method, String url, [data, onSuccess(XMLHttpRequest request), onFail(XMLHttpRequest request), Logger logger]) {
    final request =_buildXMLHttpRequest(method, url, onResponse : (XMLHttpRequest request){
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
  
  static XMLHttpRequest _buildXMLHttpRequest(String method, String url, [onRequest(XMLHttpRequest request), onResponse(XMLHttpRequest response)]) {
    final request = new XMLHttpRequest();
    request.open(method, url);
    request.withCredentials = true;
    
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
