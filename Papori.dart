#import('dart:html');
#import('src/client/adapter/TwitterAdapter.dart');
#import('src/shared/data/UserToFollow.dart');
#source('src/client/template/Alert.dart');
#source('src/client/template/Dashboard.dart');

void main() {
  displayDartStatus();
  displayTwitterTestButton();
  
  UserToFollow user1 = new UserToFollow();
  user1.displayName = "Thierry Lau";
  user1.lastUpdateDate = "28/03/2012 15:52:07";
  user1.newTweetCount = 5;
  
  UserToFollow user2 = new UserToFollow();
  user2.displayName = "Guillaume Girou";
  user2.lastUpdateDate = "27/10/2012 17:58:47";
  user2.newTweetCount = 12;
  
  UserToFollow user3 = new UserToFollow();
  user3.displayName = "Didier Girard";
  user3.lastUpdateDate = "15/01/2012 15:55:24";
  user3.newTweetCount = 40;
  
  var usersToFollow = new List<UserToFollow>();
  usersToFollow.addAll([user1, user2, user3]);
  
  displayDashboard(usersToFollow);
}

void displayDartStatus() {
  document.query('#status').innerHTML = "Papori <span class=\"label label-success\">Dart is running</span>";
}

/**
 * Display an alert Popup
 * @param header alert header
 * @param message alert message
 * @param alertType "alert-success", "alert-error", "alert-info"
 */
void displayAlert(String header, String message, String alertType){
  // Instantiation du widget Alert
  Alert alert = new Alert(header, message, "row ${alertType}");
  
  // Ajout du widget Alert dans l'élément d'id container
  var alertElement = new Element.html(alert.root.outerHTML);
  document.query("#container").elements.add(alertElement);
}

void displayDashboard(var usersToFollow){
   Dashboard dashboard = new Dashboard(usersToFollow);
   var dashboardElement = new Element.html(dashboard.root.outerHTML);
   document.query("#container").elements.add(dashboardElement);
}

void displayTwitterTestButton(){
  // Ajout d'un bouton de test Twitter
  var button = new ButtonElement();
  button.text = "Twitter Test";
  button.attributes['class'] = "btn btn-primary";
  button.on.click.add((Event event) {
    TwitterAdapter adapter = new TwitterAdapter();
    adapter.twitterApiUrl = "http://${window.location.host}/twitter";
    print("Twitter Url : ${adapter.twitterApiUrl}");
    adapter.testConnection((result) => displayAlert("Response", result ? "Succeeded" : "FAILED", result ? "alert-success" : "alert-error"));
  });
  document.query("#content").elements.add(button);
}