#library("UserTimeline");
#import('../../jsonObject/JsonObject.dart');
#import('UserActivity.dart');

interface UserTimeline extends JsonObject {
  
  List<UserActivity> userActivities;
  
}
