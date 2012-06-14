#library('adapter');

#import('dart:html');
#import('dart:uri');
#import('../../../../../dart-editor/dart-sdk/lib/unittest/unittest.dart');
#import('../../Runnable.dart');
#import('../../../src/client/adapter/TwitterAdapter.dart');

class TwitterAdapterTest implements Runnable {
  run() {
    group('TwitterAdapterTest', () {
      test('testConnectionOk', () {
        var adapter = new TwitterAdapter();
        // à faire tourner sur le serveur Papori
        adapter.twitterApiUrl = "http://${window.location.host}/twitter";
        
        var callback = expectAsync1((result) {
          print(result);
          expect(result, equals(true));
        });
        
        adapter.testConnection().then(callback);
      });
      
      test('buildRawSignature', () {
        String method = 'pOsT';
        Uri url = new Uri.fromString('https://api.twitter.com:8443/1/statuses/update.json?url_param=tr+ue');
        Map<String, List<String>> parameters = { 
                                                'status' : ['Hello+world!'], 
                                                'avec espace' : ['avec espace2', 'avec espace'], 
        };
        
        String output = TwitterAdapter.buildRawSignature(method, url, parameters);
        
        expect(output, equals(@'POST'
          '&https%3A%2F%2Fapi.twitter.com%3A8443%2F1%2Fstatuses%2Fupdate.json'
        '&avec%2520espace%3Davec%2520espace%26avec%2520espace%3Davec%2520espace2%26status%3DHello%252Bworld!%26url_param%3Dtr%252Bue'));
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
    });
  }
}