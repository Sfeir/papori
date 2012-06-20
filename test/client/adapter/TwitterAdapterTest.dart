#library('adapter');

#import('../../../../../dart-editor/dart-sdk/lib/unittest/unittest.dart');
#import('../../../test/Runnable.dart');

#import('dart:html');

#import('../../../src/client/adapter/TwitterAdapter.dart');

class TwitterAdapterTest implements Runnable {
  run() {
    test('testConnectionOk', () {
      var adapter = new TwitterAdapter();
      // à faire tourner sur le serveur Papori
      adapter.proxyUrl = "http://${window.location.host}/twitter";
      
      var callback = expectAsync1((bool result) {
        expect(result, equals(true));
      });
      
      adapter.testConnection().then(callback);
    });
    
    test('testConnectionKo', () {
      var adapter = new TwitterAdapter();
      // à faire tourner sur le serveur Papori
      adapter.proxyUrl = "http://${window.location.host}/nowhere";
      
      var callback = expectAsync1((bool result) {
        expect(result, equals(false));
      });
      
      adapter.testConnection().then(callback);
    });
    
    test('requestToken', () {
      var adapter = new TwitterAdapter();
      // à faire tourner sur le serveur Papori
      adapter.proxyUrl = "http://${window.location.host}/twitter";
      
      var callback = expectAsync1((String result) {
        print(result);
        expect(result, equals(""));
      });
      
      adapter.requestToken("http://localhost:8080/Papori.html").then(callback);
    });
  }
}