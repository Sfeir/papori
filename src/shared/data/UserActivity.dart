#library("UserActivity");
#import('package:dartwatch-JsonObject/JsonObject.dart');

interface UserActivity extends JsonObject {
  
  int id;
  String created_at;
  
}
