#import('dart:html');
#import('src/client/adapter/TwitterAdapter.dart');
#import('package:log4dart/lib.dart');
#import('src/shared/data/UserToFollow.dart');
#import('src/shared/data/Error.dart');
#source('src/client/template/Errors.dart');
#source('src/client/template/Alert.dart');
#source('src/client/template/Dashboard.dart');
#source('src/client/template/DashboardItem.dart');

class Papori {
  final Logger _logger;

  Papori() : _logger = LoggerFactory.getLogger("Papori");

  void display(){
    _displayDartStatus();
    _displayFollowBlock();
    _displayTwitterTestButton();
    _displayPaporiTestButton();
    _displayDashboard();
    _displayListErrors();
  }

  void _displayDartStatus() {
    document.query('#status').innerHTML = "Papori <span class=\"label label-success\">Dart is running</span>";
  }

  _checkForNewTwitterActivities(){
    var url = "http://${window.location.host}/papori/";

    var request = new XMLHttpRequest.get(url, onRequestSuccess(XMLHttpRequest req) {
      _displayAlert("Papori result", req.responseText, "alert-success");
    });
  }

	/**
	 * Display an alert Popup
	 * @param header alert header
	 * @param message alert message
	 * @param alertType "alert-success", "alert-error", "alert-info"
	 */
	void _displayAlert(String header, String message, String alertType){
	  // Instantiation du widget Alert
	  Alert alert = new Alert(header, message, alertType);

	  // Ajout du widget Alert dans l'élément d'id container
	  var alertElement = new Element.html(alert.root.outerHTML);
	  document.query("#container").elements.add(alertElement);
	}

	void _displayDashboard(){
	   Dashboard dashboard = new Dashboard();
	   var dashboardElement = new Element.html(dashboard.root.outerHTML);
	   document.query("#container").elements.add(dashboardElement);
	}

	void _displayListErrors(){
	  Error error = new Error();
	  error.title = "NullPointerException";
	  error.message = """Exception in thread "main" java.lang.NullPointerException
  at javaerrornullpointerexception.main(javaerrornullpointerexception.java:8)
Java Result: 1""";
    Error error2 = new Error();
    error2.title = "ArrayOutOfBoundException";
    error2.message = """java.lang.ArrayIndexOutOfBoundsException: 0""";
	  List errors = [error, error2];
	  Errors errorsWidget = new Errors("Errors", errors, "alert-danger");
	  var dashboardElement = new Element.html(errorsWidget.root.outerHTML);
    document.query("#container").elements.add(dashboardElement);
	}

  void _displayTwitterTestButton(){
    // Ajout d'un bouton de test Twitter
    var button = new ButtonElement();
    button.text = "Twitter Test";
    button.attributes['class'] = "btn btn-primary";
    button.style.margin = "10px";
    button.on.click.add((Event event) {
      TwitterAdapter adapter = new TwitterAdapter();
      adapter.proxyUrl = "http://${window.location.host}/twitter";
      _logger.info("Twitter Url : ${adapter.proxyUrl}");
      adapter.testConnection().then((result) => _displayAlert("Response", result ? "Succeeded" : "FAILED", result ? "alert-success" : "alert-error"));
    });
    document.query("#content").elements.add(button);
  }

  void _displayPaporiTestButton(){
    // Ajout d'un bouton de test Twitter
    var button = new ButtonElement();
    var intervalConsumerId;
    button.text = "Check for new tweets periodically";
    button.attributes['class'] = "btn btn-success";
    button.on.click.add((Event event) {
      // if the user start the cron ...
      if(button.attributes['class'] == "btn btn-success"){
        button.text = "Stop checking for new tweets";
        button.attributes['class'] = "btn btn-danger";
        intervalConsumerId = window.setInterval(_checkForNewTwitterActivities, 1000);
      } else {
        button.text = "Check for new tweets periodically";
        button.attributes['class'] = "btn btn-success";
        window.clearInterval(intervalConsumerId);
      }

    });
    document.query("#content").elements.add(button);

  }

  void _displayFollowBlock(){
    DivElement form = new DivElement();
    form.attributes['class'] = "well form-search";
    ButtonElement followButton = new ButtonElement();
    followButton.text = "Suivre";
    followButton.attributes['type'] = "submit";
    followButton.attributes['class'] = "btn btn-info";
    InputElement searchField = new InputElement("text");
    searchField.attributes['class'] = "input-large search-query";
    searchField.style.marginRight = "5px";
    followButton.on.click.add((Event event){
      // TODO add userToFollow in the table
      var userToFollow = searchField.value;
      UserToFollow user = new UserToFollow();
      user.displayName = userToFollow;
      user.newTweetCount = 15;
      user.id = "44864846";
      user.lastUpdateDate = "17/05/2012 14:50:20";
      _addUserToFollowInDashboard(user);
      document.query("#delete${user.displayName}").on.click.add((Event event2){
        document.query("#item${user.displayName}").remove();
      });
    });
    form.elements.add(searchField);
    form.elements.add(followButton);

    document.query("#container").elements.add(form);
  }

  void _addUserToFollowInDashboard(UserToFollow user){
    DashboardItem dashboardElement = new DashboardItem(user);
    var dashboardItemElement = new Element.html(dashboardElement.root.outerHTML);
    document.query("#dashboard-body").elements.add(dashboardItemElement);
  }

}

void main() {
  new Papori().display();
}
