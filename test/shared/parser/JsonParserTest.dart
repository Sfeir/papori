#library('JsonParserTest');

#import('package:dartwatch-JsonObject/JsonObject.dart');
#import('../../../../../dart-editor/dart-sdk/lib/unittest/unittest.dart');

class JsonParserTest {
  
  var jsonSample = '''
      [
      {
      "created_at": "Fri Jun 08 11:24:54 +0000 2012",
      "id": 211056200366833660,
      "id_str": "211056200366833664",
      "text": "http://t.co/BA7vRXY9 by @geeksam. Very good and easy to read tutorial on Git ! #git",
      "source": "web",
      "truncated": false,
      "in_reply_to_status_id": null,
      "in_reply_to_status_id_str": null,
      "in_reply_to_user_id": null,
      "in_reply_to_user_id_str": null,
      "in_reply_to_screen_name": null,
      "user": {
      "id": 168265016,
      "id_str": "168265016",
      "name": "LAU Thierry",
      "screen_name": "laut3rry",
      "location": "",
      "description": "Développeur @SFEIRfr",
      "url": "http://devsnote.com/",
      "protected": false,
      "followers_count": 22,
      "friends_count": 75,
      "listed_count": 1,
      "created_at": "Sun Jul 18 21:48:08 +0000 2010",
      "favourites_count": 2,
      "utc_offset": 3600,
      "time_zone": "Paris",
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 117,
      "lang": "fr",
      "contributors_enabled": false,
      "is_translator": false,
      "profile_background_color": "C6E2EE",
      "profile_background_image_url": "http://a0.twimg.com/images/themes/theme2/bg.gif",
      "profile_background_image_url_https": "https://si0.twimg.com/images/themes/theme2/bg.gif",
      "profile_background_tile": false,
      "profile_image_url": "http://a0.twimg.com/profile_images/1815033398/moi_small_normal.jpg",
      "profile_image_url_https": "https://si0.twimg.com/profile_images/1815033398/moi_small_normal.jpg",
      "profile_link_color": "1F98C7",
      "profile_sidebar_border_color": "C6E2EE",
      "profile_sidebar_fill_color": "DAECF4",
      "profile_text_color": "663B12",
      "profile_use_background_image": true,
      "show_all_inline_media": false,
      "default_profile": false,
      "default_profile_image": false,
      "following": null,
      "follow_request_sent": null,
      "notifications": null
      },
      "geo": null,
      "coordinates": null,
      "place": null,
      "contributors": null,
      "retweet_count": 0,
      "entities": {
      "hashtags": [
      {
      "text": "git",
      "indices": [
      79,
      83
      ]
      }
      ],
      "urls": [
      {
      "url": "http://t.co/BA7vRXY9",
      "expanded_url": "http://think-like-a-git.net/",
      "display_url": "think-like-a-git.net",
      "indices": [
      0,
      20
      ]
      }
      ],
      "user_mentions": [
      {
      "screen_name": "geeksam",
      "name": "Sam Livingston-Gray",
      "id": 38699900,
      "id_str": "38699900",
      "indices": [
      24,
      32
      ]
      }
      ]
      },
      "favorited": false,
      "retweeted": false,
      "possibly_sensitive": false
      }
      ]
''';
  
  run() {
    test('Json Parsing', () {
      JsonObject result = new JsonObject.fromJsonString(jsonSample);
      expect(result[0].id, equals(211056200366833660));
      expect(result[0].user.name, equals("LAU Thierry"));
      expect(result[0].entities.hashtags[0].text, equals("git"));
    });
}
}  
