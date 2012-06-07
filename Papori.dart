#import('dart:html');
#source('src/template/Alert.dart');

void main() {
  show('Hello, World!');
  displayAlert();
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