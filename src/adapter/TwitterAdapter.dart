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
    print("URL: $url\n");

    // call the web server asynchronously 
    var request = new XMLHttpRequest.get(url, onRequestSuccess(XMLHttpRequest req) {
      print("RESPONSE: ${req.status} - ${req.responseText}\n");
      onSuccess(req.status == 200 && req.responseText == """ok""");
    });
  }
  
  void main() {
    testConnection((result) => print(result));
  }

  set twitterApiUrl(String value) => _twitterApiUrl = value;
}
