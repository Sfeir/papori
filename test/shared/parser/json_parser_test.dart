#library('JsonParserTest');

#import('dart:json');
#import('package:unittest/unittest.dart');
#import('package:dartwatch-JsonObject/JsonObject.dart');

class JsonParserTest {

  var jsonSample = '''
[ { "contributors" : null,
    "coordinates" : null,
    "created_at" : "Fri Jun 08 11:24:54 +0000 2012",
    "entities" : { "hashtags" : [ { "indices" : [ 79,
                  83
                ],
              "text" : "git"
            } ],
        "urls" : [ { "display_url" : "think-like-a-git.net",
              "expanded_url" : "http://think-like-a-git.net/",
              "indices" : [ 0,
                  20
                ],
              "url" : "http://t.co/BA7vRXY9"
            } ],
        "user_mentions" : [ { "id" : 38699900,
              "id_str" : "38699900",
              "indices" : [ 24,
                  32
                ],
              "name" : "Sam Livingston-Gray",
              "screen_name" : "geeksam"
            } ]
      },
    "favorited" : false,
    "geo" : null,
    "id" : 211056200366833660,
    "id_str" : "211056200366833664",
    "in_reply_to_screen_name" : null,
    "in_reply_to_status_id" : null,
    "in_reply_to_status_id_str" : null,
    "in_reply_to_user_id" : null,
    "in_reply_to_user_id_str" : null,
    "place" : null,
    "possibly_sensitive" : false,
    "retweet_count" : 0,
    "retweeted" : false,
    "source" : "web",
    "text" : "http://t.co/BA7vRXY9 by @geeksam. Very good and easy to read tutorial on Git ! #git",
    "truncated" : false,
    "user" : { "contributors_enabled" : false,
        "created_at" : "Sun Jul 18 21:48:08 +0000 2010",
        "default_profile" : false,
        "default_profile_image" : false,
        "description" : "Développeur @SFEIRfr",
        "favourites_count" : 2,
        "follow_request_sent" : null,
        "followers_count" : 22,
        "following" : null,
        "friends_count" : 75,
        "geo_enabled" : false,
        "id" : 168265016,
        "id_str" : "168265016",
        "is_translator" : false,
        "lang" : "fr",
        "listed_count" : 1,
        "location" : "",
        "name" : "LAU Thierry",
        "notifications" : null,
        "profile_background_color" : "C6E2EE",
        "profile_background_image_url" : "http://a0.twimg.com/images/themes/theme2/bg.gif",
        "profile_background_image_url_https" : "https://si0.twimg.com/images/themes/theme2/bg.gif",
        "profile_background_tile" : false,
        "profile_image_url" : "http://a0.twimg.com/profile_images/1815033398/moi_small_normal.jpg",
        "profile_image_url_https" : "https://si0.twimg.com/profile_images/1815033398/moi_small_normal.jpg",
        "profile_link_color" : "1F98C7",
        "profile_sidebar_border_color" : "C6E2EE",
        "profile_sidebar_fill_color" : "DAECF4",
        "profile_text_color" : "663B12",
        "profile_use_background_image" : true,
        "protected" : false,
        "screen_name" : "laut3rry",
        "show_all_inline_media" : false,
        "statuses_count" : 117,
        "time_zone" : "Paris",
        "url" : "http://devsnote.com/",
        "utc_offset" : 3600,
        "verified" : false
      }
  } ]
''';

  run() {
    test('Json Parsing', () {
//      var result = new JsonObject.fromJsonString(jsonSample);
      var result = JSON.parse(jsonSample);
      print(result);
      expect(result.length, equals(1));
      expect(result[0]['id'], equals(211056200366833660));
      expect(result[0]['user']['name'], equals("LAU Thierry"));
      expect(result[0]['entities']['hashtags'][0]['text'], equals("git"));
    });
  }
}
