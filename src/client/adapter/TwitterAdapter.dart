#library('adapter');

#import('dart:html');
#import('dart:json');
#import('dart:uri');
#import('package:log4dart/Lib.dart');

#import('../../../src/client/utils/XMLHttpRequests.dart');
#import('../../../src/shared/utils/OAuth.dart');

#import('../../../src/shared/data/UserToFollow.dart');

/**
* Adapter for Twitter REST API.
*/
class TwitterAdapter {
  final Logger _logger;
  
  String twitterApiUrl = 'http://api.twitter.com';
  String proxyUrl = 'https://api.twitter.com';
  String consumerKey = 'zxye2O5CZiVaT507MGplGw';
  String authToken = '';
  
  static final String _TEST_URL =  '/1/help/test.json';
  static final String _REQUEST_TOKEN_URL =  '/oauth/request_token';
  
  TwitterAdapter() : _logger = LoggerFactory.getLogger("TwitterAdapter");
  
  /**
  * Test the connection with twitter.
  * See https://dev.twitter.com/docs/api/1/get/help/test
  */
  Future<bool> testConnection() {
    Completer<bool> result = new Completer();
    
    var url = "$proxyUrl$_TEST_URL"; 

    // call the web server asynchronously 
    XMLHttpRequests.getXMLHttpRequest(url, 
      onSuccess : (XMLHttpRequest req) {
        result.complete(req.responseText == '"ok"');
      }, 
      onFail : (XMLHttpRequest req) {
        result.complete(false);
      });
    
    return result.future;
  }
  
  /**
  * Obtient un token d'autorisation.
  *
  * https://dev.twitter.com/docs/api/1/post/oauth/request_token
  * https://api.twitter.com/oauth/request_token
  */
  Future<String> requestToken(String callbackUrl){
    Map<String, String> oauthParameters = {
                                           'oauth_nonce' : OAuth.randomKey(),
                                           'oauth_callback' : callbackUrl,
                                           'oauth_signature_method' : 'HMAC-SHA1',
                                           'oauth_timestamp' : (new Date.now().value / 1000).toInt().toString(),
                                           'oauth_consumer_key' : consumerKey,
                                           'oauth_version' : '1.0',
    };
    
    String method = 'POST';
    var url = "$proxyUrl$_REQUEST_TOKEN_URL"; 
    var twitterUrl = new Uri.fromString("$twitterApiUrl$_REQUEST_TOKEN_URL"); 

    var baseSignature = OAuth.buildRawBaseSignature(method, twitterUrl, oauthParameters);
    _logger.debug(baseSignature);
    oauthParameters['oauth_signature'] = OAuth.hashSignature(baseSignature, consumerKey);
    oauthParameters['oauth_callback'] = "$callbackUrl/Papori.html";

    Completer<String> result = new Completer();

    // call the web server asynchronously 
    XMLHttpRequests.postXMLHttpRequest(url, headers : { 'Authorization' : [OAuth.concatOAuthParameters(oauthParameters)] }, 
      onSuccess : (XMLHttpRequest req) {
        result.complete(req.responseText);
      },
      onFail : (XMLHttpRequest req) {
        result.complete(req.responseText);
      });
    
    return result.future;
  }
    
  /**
  * Check for a user Twitter posted statuses and return the number of new statuses
  */
  checkTwitterActivityOfUser(UserToFollow user, int resultCount, onSuccess(String newTweet)){
    var url = "$proxyUrl$_STATUSES_USER_TIMELINE";
    print("GET - $url");
    var request = new XMLHttpRequest.get(url, onRequestSuccess(XMLHttpRequest request) {
      print("${request.status} - $_TEST_URL - ${request.responseText}");
      onSuccess("There is ${request.responseText} new tweets");
    });
  }
}
