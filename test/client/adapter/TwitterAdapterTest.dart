#library('tests_adapter');

#import('dart:html');
#import('../../../../../dart-editor/dart-sdk/lib/unittest/unittest.dart');
#import('../../Runnable.dart');
#import('../../../src/client/adapter/TwitterAdapter.dart');

class TwitterAdapterTest implements Runnable {
  run() {
    test('testConnectionOk', () {
      var adapter = new TwitterAdapter();
      // à faire tourner sur le serveur Papori
      adapter.twitterApiUrl = "http://${window.location.host}/twitter";

      var callback = expectAsync1((result) {
        print(result);
        expect(result, equals(true));
      });
      
      adapter.testConnection(callback);
    });
    
    // TODO
//    test('testConnectionKo', () {
//      var adapter = new TwitterAdapter();
//      // à faire tourner sur le serveur Papori
//      adapter.twitterApiUrl = "http://${window.location.host}/nowhere";
//      
//      var callback = expectAsync1((result) {
//        print(result);
//        expect(result, equals(false));
//      });
//      
//      adapter.testConnection(callback);
//    });
  }
}