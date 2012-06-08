#library("JsonParser");
#import('../../jsonObject/JsonObject.dart');
class JsonParser {
  
  parseTwitterJson(var jsonString){
    
    var twitterInfo = new JsonObject.fromJsonString(jsonString);
    return twitterInfo;
    
  }
  
}
