#library('util');

#import('dart:uri');
#import('dart:crypto');
#import('dart:utf');

#import('../../../src/shared/utils/Base64.dart');
#import('../../../src/shared/utils/Uris.dart');
#import('../../../src/shared/utils/Comparison.dart');

/**
* Classe utilitaire pour la construction des entêtes OAuth 1.0.
* https://dev.twitter.com/docs/auth/creating-signature
*/
class OAuth {
//  static int randomInt() {
//    return (Math.random() * (1 << 32)).toInt() ^ new Date.now().value;
//  }
//  
//  
//  static List<int> _intToBytes(int value) {
//    var result = [];
//    while(value != 0){
//      result.add(value & 0xFF);
//      value >>= 8;
//    }
//    return result;
//  }
//
//  static List<int> randomBytes(int number) {
//    new List((number / 4).ceil().toInt()).forEach(f);
//    return [].;
//  }
  
  static String randomKey(){
    // TODO : l'aléatoire peut être optimisé
    return Base64.encode(new List(32).map((e)=> ((Math.random() * 256) + 1).toInt() ^ new Date.now().value));
  }
  
  /**
  * Construit la signature de base pour une requête.
  */
  static String buildRawBaseSignature(String method, Uri url, [Map<String, String> oauthParameters, Map<String, List<String>> parameters]){
    // https://dev.twitter.com/docs/auth/creating-signature
    
    StringBuffer result = new StringBuffer();
    // HTTP Method to uppercase
    result.add(method.toUpperCase());
    result.add('&');
    
    // Encoded base URL
    Uri baseUrl = new Uri(url.scheme.toLowerCase(), url.userInfo, url.domain.toLowerCase(), url.port, url.path);
    result.add(encodeUriComponent(baseUrl.toString()));
    result.add('&');

    // Key sorted and encoded parameters
    Map<String, List<String>> paramsMap = new Map();
    if(oauthParameters != null){
      oauthParameters.forEach((key, value) => paramsMap.putIfAbsent(key, () => []).add(value));
    }
    for(Map<String, List<String>> params in [parameters, Uris.parseUriQuery(url)]){
      if(params != null){
        params.forEach((key, values) => paramsMap.putIfAbsent(key, () => []).addAll(values));
      }
    }
    print(paramsMap);

    result.add(encodeUriComponent(_concatSignatureParameters(paramsMap)));
    
    return result.toString();
  }
 
  /**
  * Concatene les parametres de la signature.
  */
  static String _concatSignatureParameters(Map<String, List<String>> parameters){
    // TODO : use TreeMap when implemenented
    Map<String, List<String>> paramsMap = new Map();
    // Deep copy
    parameters.forEach((key, values) { 
      paramsMap[key] = new List.from(values);
      paramsMap[key].sort(Comparison.asc);
    });
    
    List<String> keys = new List.from(paramsMap.getKeys());
    keys.sort(Comparison.asc);
    
    List<String> params = [];
    keys.map((key) => paramsMap[key].forEach((value) => params.add(encodeKeyValueParameter(key, value))));
    
    return Strings.join(params, '&');
  }
  
  /**
  * Hash la signature avec la méthode HMAC-SHA1, la consumerKey et le token d'authentification si présent.
  */
  static String hashSignature(String baseSignature, String consumerKey, [String token = '']) {
    String signingKey = token == null ? "${encodeUriComponent(consumerKey)}&" : "${encodeUriComponent(consumerKey)}&${encodeUriComponent(token)}";
    HMAC hmac = new HMAC(new SHA1(), encodeUtf8(signingKey));
    hmac.update(encodeUtf8(baseSignature));
    return Base64.encode(hmac.digest());
  }
  
  /**
  * Concatène les parametres OAuth, pour l'entete HTTP Authorization.
  */
  static String concatOAuthParameters(Map<String, String> oauthParameters) {
    List<String> params = [];
    oauthParameters.forEach((key, value) => params.add("${encodeUriComponent(key)}=\"${encodeUriComponent(value)}\""));

    StringBuffer result = new StringBuffer('OAuth ');
    result.add(Strings.join(params, ', '));
    return result.toString();
  }
  
  static String encodeKeyValueParameter(String key, [String value]){
    return value == null ? encodeUriComponent(key) : "${encodeUriComponent(key)}=${encodeUriComponent(value)}";
  }
}
