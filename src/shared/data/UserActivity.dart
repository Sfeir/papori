#library("UserActivity");
#import('package:jsonObject/JsonObject.dart');

interface UserActivity extends JsonObject {
  
  int id;
  String created_at;
  
}
