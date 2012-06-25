#library('utils');

#import('dart:uri');

/**
* Classe utilitaire pour les objets Uri
*/
class Uris {
  static Map<String, List<String>> parseUriQuery(Uri url){
    return parseQuery(url.query);
  }
  
  static Map<String, List<String>> parseQuery(String query){
    return parseFormUrlEncoded(query.startsWith('?') ? query.substring(1) : query);
  }
  
  static Map<String, List<String>> parseFormUrlEncoded(String content){
    Map<String, List<String>> result = new LinkedHashMap();
    List<List<String>> keyValues = content.split('&')
        .filter((keyValue) => !keyValue.isEmpty())
        .map((keyValue) => keyValue.split('='));
    keyValues.forEach((keyValue) {
      var key = decodeUriComponent(keyValue[0]);
      var value = keyValue.length > 1 ? decodeUriComponent(keyValue[1]) : null;
      if(!result.containsKey(key)){
        result[key] = [];
      }
      result[key].add(value);
    });
    
    return result;
  }
}
