#library('util');

#import('dart:uri');

#import('package:unittest/unittest.dart');
#import('../../../test/runnable.dart');


#import('../../../src/shared/utils/oauth.dart');
#import('../../../src/shared/utils/base_64.dart');

class OAuthTest implements Runnable {
  run() {
    test('buildRawBaseSignature', () {
      String method = 'pOsT';
      Uri url = new Uri.fromString('HTTPS://Api.twitter.com:8443/1/statuses/update.json?url_param=tr+ue');
      Map<String, String> oauthParameters = {
                                           'oauth_toto' : 'a',
                                           'oauth_other' : 'b',
      };
      Map<String, List<String>> parameters = {
                                              'status' : ['Hello+world!'],
                                              'avec espace' : ['avec espace2', 'avec espace'],
      };

      String output = OAuth.buildRawBaseSignature(method, url, oauthParameters, parameters);
      expect(output, equals(@'POST'
        '&https%3A%2F%2Fapi.twitter.com%3A8443%2F1%2Fstatuses%2Fupdate.json'
      '&avec%2520espace%3Davec%2520espace%26avec%2520espace%3Davec%2520espace2%26oauth_other%3Db%26oauth_toto%3Da%26status%3DHello%252Bworld!%26url_param%3Dtr%252Bue'));
    });

    group('hashSignature', () {
      test('withTokenSecret', () {
        String baseSignature = @'POST&https%3A%2F%2Fapi.twitter.com%2F1%2Fstatuses%2Fupdate.json&include_entities%3Dtrue%26oauth_consumer_key%3Dxvz1evFS4wEEPTGEFPHBog%26oauth_nonce%3DkYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1318622958%26oauth_token%3D370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb%26oauth_version%3D1.0%26status%3DHello%2520Ladies%2520%252B%2520Gentlemen%252C%2520a%2520signed%2520OAuth%2520request%2521';
        String consumerSecret = 'kAcSOqF21Fu85e7zjz7ZN2U4ZRhfV3WpwPAoE3Z7kBw';
        String tokenSecret = 'LswwdoUaIvS8ltyTt5jkRh4J50vUPVVHtR2YPi5kE';

        String output = OAuth.hashSignature(baseSignature, consumerSecret, tokenSecret);

        // http://hash.online-convert.com/sha1-generator
        expect(output, equals('tnnArxj06cWHq44gCs1OSKk/jLY='));
      });

      test('withoutTokenSecret', () {
        String baseSignature = 'test';
        String consumerSecret = 'abc&123';

        String output = OAuth.hashSignature(baseSignature, consumerSecret);

        // http://hash.online-convert.com/sha1-generator
        expect(output, equals('MagJ/y6G5zqAV+f1+daJHPtq1HY='));
      });
    });

    test('getNonce', () {
      String output = OAuth.getNonce();

      List<int> bytes = Base64.decode(output);
      expect(bytes, everyElement(lessThan(256)));
      expect(bytes.length, equals(32));
    });

    test('concatOAuthParameters', () {
      Map<String, String> oauthParameters = {
                                             'oauth_t&oto' : 'a=',
                                             'oauth_other' : 'b',
        };

      String output = OAuth.concatOAuthParameters(oauthParameters);

      expect(output, equals('OAuth oauth_t%26oto="a%3D", oauth_other="b"'));
    });
  }
}
