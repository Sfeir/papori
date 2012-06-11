#import('dart:html');
#import('src/client/adapter/TwitterAdapter.dart');
#source('src/client/template/Alert.dart');

void main() {
  displayDartStatus();
  displayTwitterTestButton();
}

void displayDartStatus() {
  document.query('#status').innerHTML = "Papori <span class=\"label label-success\">Dart is running</span>";
}

/**
 * @param header alert header
 * @param message alert message
 * @param alertType "alert-success", "alert-error", "alert-info"
 */
void displayAlert(String header, String message, String alertType){
  // Instantiation du widget Alert
  Alert alert = new Alert(header, message, alertType);
  
  // Ajout du widget Alert dans l'élément d'id container
  var e1 = new Element.html(alert.root.outerHTML);
  document.query("#container").elements.add(e1);
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
  document.query("#container").elements.add(button);
}