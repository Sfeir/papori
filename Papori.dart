#import('dart:html');
#import('src/client/adapter/TwitterAdapter.dart');
#source('src/client/template/Alert.dart');

void main() {
  show('Hello, World!');
  displayAlert();
  displayTwitterTestButton();
}

void show(String message) {
  document.query('#status').innerHTML = message;

}

void displayAlert(){
  // Instantiation du widget Alert
  Alert alert = new Alert("Note", "Ceci est widget créé par template!", "alert-success");
  
  // Ajout du widget Alert dans l'élément d'id container
  var e1 = new Element.html(alert.root.outerHTML);
  document.query("#container").elements.add(e1);
}

void displayTwitterTestButton(){
  // Ajout d'un bouton de test Twitter
  var button = new ButtonElement();
  button.text = "Twitter Test";
  button.on.click.add((Event event) {
    TwitterAdapter adapter = new TwitterAdapter();
    adapter.twitterApiUrl = "http://${window.location.host}/twitter";
    print("Twitter Url : ${adapter.twitterApiUrl}");
    adapter.testConnection((result) => window.alert(result ? "Succeeded" : "FAILED"));
  });
  document.query("#container").elements.add(button);
}