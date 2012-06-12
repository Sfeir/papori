#library('adapter');

#import('dart:html');
#import('dart:json');
#import('package:log4dart/Lib.dart');

#import('../../shared/data/UserToFollow.dart');

/**
* Adapter for Twitter REST API.
*/
class TwitterAdapter {
  final Logger _logger;
  
  String twitterApiUrl = 'https://api.twitter.com';
  
  static final String _TEST_URL =  '/1/help/test.json';
  
  TwitterAdapter() : _logger = LoggerFactory.getLogger("TwitterAdapter");
  
  /**
  * Test the connection with twitter.
  * See https://dev.twitter.com/docs/api/1/get/help/test
  */
  testConnection(onSuccess(bool result)) {
    var url = "$twitterApiUrl$_TEST_URL"; 
    _logger.info("GET - $url");

    // call the web server asynchronously 
    var request = new XMLHttpRequest.get(url, onRequestSuccess(XMLHttpRequest req) {
      _logger.info("${req.status} - $_TEST_URL - ${req.responseText}");
      onSuccess(req.responseText == "\"ok\"");
    });
  }
  
  /**
  * Check for a user Twitter posted statuses and return the number of new statuses
  */
  checkTwitterActivityOfUser(UserToFollow user, int resultCount, onSuccess(String newTweet)){
    var url = "$twitterApiUrl$_STATUSES_USER_TIMELINE";
    print("GET - $url");
    var request = new XMLHttpRequest.get(url, onRequestSuccess(XMLHttpRequest request) {
      print("${request.status} - $_TEST_URL - ${request.responseText}");
      onSuccess("There is ${request.responseText} new tweets");
    });
  }
  
}
