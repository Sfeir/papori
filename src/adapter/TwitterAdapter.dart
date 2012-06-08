#library('adapter');

#import('dart:html');
#import('dart:json');

/**
* Adapter for Twitter REST API.
*/
class TwitterAdapter {
  String _twitterApiUrl = 'https://api.twitter.com';
  
  static final String _TEST_URL =  '/1/help/test.json';
  
  /**
  * Test the connection with twitter.
  * See https://dev.twitter.com/docs/api/1/get/help/test
  */
  testConnection(onSuccess(bool result)) {
    var url = "$_twitterApiUrl$_TEST_URL"; 
    print("GET - $url");

    // call the web server asynchronously 
    var request = new XMLHttpRequest.get(url, onRequestSuccess(XMLHttpRequest req) {
      print("${req.status} - $_TEST_URL - ${req.responseText}");
      onSuccess(req.responseText == "\"ok\"");
    });
  }
  
  String get twitterApiUrl() => _twitterApiUrl;
  set twitterApiUrl(String value) => _twitterApiUrl = value;
}
