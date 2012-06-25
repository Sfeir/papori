#library('tests');

#import('dart:html');
#import('package:unittest/unittest.dart');
#import('package:unittest/html_config.dart');
#import('package:unittest/html_enhanced_config.dart');
#import('./runnable.dart');

#import('./client/adapter/twitter_adapter_test.dart');
#import('./shared/parser/json_parser_test.dart');
#import('./client/utils/xml_http_requests_test.dart');
#import('./shared/utils/uris_test.dart');
#import('./shared/utils/oauth_test.dart');

/**
* Run the tests suite
*/
class TestSuite {
  final Map<String, Runnable> _tests;

  TestSuite() : _tests = {
                          'TwitterAdapterTest' : new TwitterAdapterTest(),
                          // FIXME : corriger ce test
                          'JsonParserTest' : new JsonParserTest(),
                          'UrisTest' : new UrisTest(),
                          'OAuthTest' : new OAuthTest(),
  };

  void run() {
    _tests.forEach((name, _test) {
      group(name, _test.run);
    });
  }
}

void main() {
  document.query('#status').innerHTML = 'Running...';

  useHtmlConfiguration();
//  useHtmlEnhancedConfiguration();

  new TestSuite().run();
}
