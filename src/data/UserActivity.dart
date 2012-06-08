#library("UserActivity");
#import('../../jsonObject/JsonObject.dart');

interface UserActivity extends JsonObject {
  
  int id;
  String created_at;
  
}
