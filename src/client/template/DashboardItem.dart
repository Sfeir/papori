// Generated Dart class from HTML template.
// DO NOT EDIT.

class DashboardItem {
  Map<String, Object> _scopes;
  Element _fragment;

  var user;

  DashboardItem(this.user) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_DashboardItem_templatesStyles();

    _fragment = new DocumentFragment();
    var e0 = new Element.html('<tr id="item${user.displayName}"></tr>');
    _fragment.elements.add(e0);
    var e1 = new Element.html('<td>${inject_0()}</td>');
    e0.elements.add(e1);
    var e2 = new Element.html('<td>${inject_1()}</td>');
    e0.elements.add(e2);
    var e3 = new Element.html('<td>${inject_2()}</td>');
    e0.elements.add(e3);
    var e4 = new Element.html('<td></td>');
    e0.elements.add(e4);
    var e5 = new Element.html('<div id="delete${user.displayName}"></div>');
    e4.elements.add(e5);
    var e6 = new Element.html('<i class="icon-remove delete"></i>');
    e5.elements.add(e6);
  }

  Element get root() => _fragment;

  // CSS class selectors for this template.
  static String get delete() => "delete";

  // Injection functions:
  String inject_0() {
    return safeHTML('${user.displayName}');
  }

  String inject_1() {
    return safeHTML('${user.newTweetCount}');
  }

  String inject_2() {
    return safeHTML('${user.lastUpdateDate}');
  }

  // Each functions:

  // With functions:

  // CSS for this template.
  static final String stylesheet = '''
    
.delete {
  margin-left: 12px;
}

.delete:hover {
  cursor: pointer;
}

  ''';

  // Stylesheet class selectors:
  String safeHTML(String html) {
    // TODO(terry): Escaping for XSS vulnerabilities TBD.
    return html;
  }
}


// Inject all templates stylesheet once into the head.
bool DashboardItem_stylesheet_added = false;
void add_DashboardItem_templatesStyles() {
  if (!DashboardItem_stylesheet_added) {
    StringBuffer styles = new StringBuffer();

    // All templates stylesheet.
    styles.add(DashboardItem.stylesheet);

    DashboardItem_stylesheet_added = true;
    document.head.elements.add(new Element.html('<style>${styles.toString()}</style>'));
  }
}
