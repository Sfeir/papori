#library('tests');

#import('dart:html');
#import('../../../dart-editor/dart-sdk/lib/unittest/unittest.dart');
#import('../../../dart-editor/dart-sdk/lib/unittest/html_config.dart');
#import('../../../dart-editor/dart-sdk/lib/unittest/html_enhanced_config.dart');
#import('./Runnable.dart');

#import('./client/adapter/TwitterAdapterTest.dart');
#import('./shared/parser/JsonParserTest.dart');
#import('./client/utils/XMLHttpRequestsTest.dart');
#import('./shared/utils/UrisTest.dart');
#import('./shared/utils/OAuthTest.dart');

/**
* Run the tests suite
*/
class TestSuite {
  final Map<String, Runnable> _tests;
  
  TestSuite() : _tests = {
                          'TwitterAdapterTest' : new TwitterAdapterTest(),
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
