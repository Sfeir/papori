#library('adapter');

#import('package:unittest/unittest.dart');
#import('../../../test/Runnable.dart');

#import('dart:html');

#import('../../../src/client/adapter/TwitterAdapter.dart');

class TwitterAdapterTest implements Runnable {
  run() {
    group('testConnection', () {
      test('Ok', () {
        var adapter = new TwitterAdapter();
        // à faire tourner sur le serveur Papori
        adapter.proxyUrl = "http://${window.location.host}/twitter";

        var callback = expectAsync1((bool result) {
          expect(result, equals(true));
        });

        adapter.testConnection().then(callback);
      });

      test('Ko', () {
        var adapter = new TwitterAdapter();
        // à faire tourner sur le serveur Papori
        adapter.proxyUrl = "http://${window.location.host}/nowhere";

        var callback = expectAsync1((bool result) {
          expect(result, equals(false));
        });

        adapter.testConnection().then(callback);
      });
    });

    group('requestToken', () {
      test('Ok', () {
        var adapter = new TwitterAdapter();
        // à faire tourner sur le serveur Papori
        adapter.proxyUrl = "http://${window.location.host}/twitter";

        var callback = expectAsync1((Map<String, List<String>> result) {
          print(result);
          expect(result.getKeys(), orderedEquals(['oauth_token', 'oauth_token_secret', 'oauth_callback_confirmed']));
          expect(result.getValues(), everyElement(everyElement(isNot(anyOf(isNull, equals(''))))));
          callbackDone();
        });
        var onException = expectAsync1((exception) {
          print(exception);
          expect(false, 'Unreachable');
          callbackDone();
          return true;
        }, count: 0);

        Future<Map<String, List<String>>> futureResult = adapter.requestToken("http://127.0.0.1:8080/Papori.html");
        futureResult.then(callback);
        futureResult.handleException(onException);
      });

      test('Ko', () {
        var adapter = new TwitterAdapter();
        // à faire tourner sur le serveur Papori
        adapter.proxyUrl = "http://${window.location.host}/nowhere";

        var callback = expectAsync1((result) {
          callbackDone();
          expect(false, 'Unreachable');
        }, count: 0);
        var onException = expectAsync1((exception) {
          callbackDone();
          expect(exception, new isInstanceOf<Exception>('Exception'));
          return true;
        });

        Future<Map<String, List<String>>> futureResult = adapter.requestToken("http://127.0.0.1:8080/Papori.html");
        futureResult.then(callback);
        futureResult.handleException(onException);
      });
    });
  }
}