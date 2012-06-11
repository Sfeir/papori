#library("UserTimeline");
#import('package:dartwatch-JsonObject/JsonObject.dart');
#import('UserActivity.dart');

interface UserTimeline extends JsonObject {
  
  List<UserActivity> userActivities;
  
}
