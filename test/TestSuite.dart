#library('tests');

#import('dart:html');
#import('../../../dart-editor/dart-sdk/lib/unittest/unittest.dart');
#import('../../../dart-editor/dart-sdk/lib/unittest/html_config.dart');
#import('./Runnable.dart');

#import('./client/adapter/TwitterAdapterTest.dart');
#import('./shared/parser/JsonParserTest.dart');

/**
* Run the tests suite
*/
class TestSuite {
  final Collection<Runnable> _tests;
  
  TestSuite() : _tests = [
                          new TwitterAdapterTest(),
                          new JsonParserTest()
                          ];
  
  void run() {
    _tests.forEach((_test) => _test.run());
  }
}

void main() {
  document.query('#status').innerHTML = 'Running...';

  useHtmlConfiguration();

  new TestSuite().run();
}
