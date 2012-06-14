#library('adapter');

#import('dart:html');
#import('dart:json');
#import('dart:uri');
#import('package:log4dart/Lib.dart');
#import('../utils/XMLHttpRequests.dart');
#import('../../shared/utils/Uris.dart');

/**
* Adapter for Twitter REST API.
*/
class TwitterAdapter {
  final Logger _logger;
  
  String _twitterApiUrl = 'https://api.twitter.com';
  
  static final String _TEST_URL =  '/1/help/test.json';
  
  TwitterAdapter() : _logger = LoggerFactory.getLogger("TwitterAdapter");
  
  /**
  * Test the connection with twitter.
  * See https://dev.twitter.com/docs/api/1/get/help/test
  */
  Future<bool> testConnection() {
    Completer result = new Completer();
    
    var url = "$_twitterApiUrl$_TEST_URL"; 

    // call the web server asynchronously 
    XMLHttpRequests.getXMLHttpRequest(url, onRequestSuccess(XMLHttpRequest req) {
      result.complete(req.responseText == '"ok"');
    }, onRequestFail(XMLHttpRequest req) {
      result.complete(false);
    });
    
    return result.future;
  }
  
  Future<String> requestToken(){
//    https://api.twitter.com/oauth/request_token
  }
  
  static String buildRawSignature(String method, Uri url, Map<String, List<String>> parameters){
    StringBuffer result = new StringBuffer();
    // HTTP Method to uppercase
    result.add(method.toUpperCase());
    result.add('&');
    
    // Encoded base URL
    Uri baseUrl = new Uri(url.scheme, url.userInfo, url.domain, url.port, url.path);
    result.add(encodeUriComponent(baseUrl.toString()));
    result.add('&');

    // Key sorted and encoded parameters
    // TODO : use TreeMap when implemenented
    Map<String, List<String>> paramsMap = new Map.from(parameters);
    Map<String, List<String>> query = Uris.parseUriQuery(url);
    query.forEach((key, values) => paramsMap.putIfAbsent(key, () => []).addAll(values));
//    paramsMaps.addAll(url.query.split('&'));
    

    result.add(encodeUriComponent(buildSignatureParametersChain(paramsMap)));
    
    return result.toString();
  }
  
  static String buildSignatureParametersChain(Map<String, List<String>> parameters){
    // Deep copy
    Map<String, List<String>> paramsMap = new Map.from(parameters);
    paramsMap.forEach((key, values) { 
      paramsMap[key] = new List.from(values);
      paramsMap[key].sort((a, b) => a.compareTo(b));
    });
    
    List<String> keys = new List.from(paramsMap.getKeys());
    keys.sort((a, b) => a.compareTo(b));
    
    List<String> params = [];
    keys.map((key) => paramsMap[key].forEach((value) => params.add("${encodeUriComponent(key)}=${encodeUriComponent(value)}")));
    
    return Strings.join(params, '&');
  }
  
    
  String get twitterApiUrl() => _twitterApiUrl;
  set twitterApiUrl(String value) => _twitterApiUrl = value;
}
