// Generated Dart class from HTML template.
// DO NOT EDIT.

class Dashboard {
  Map<String, Object> _scopes;
  Element _fragment;

  Dashboard() : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_Dashboard_templatesStyles();

    _fragment = new DocumentFragment();
    var e0 = new Element.html('<div class="row"></div>');
    _fragment.elements.add(e0);
    var e1 = new Element.html('<div class="span12"></div>');
    e0.elements.add(e1);
    var e2 = new Element.html('<table class="table table-striped"></table>');
    e1.elements.add(e2);
    var e3 = new Element.html('<thead></thead>');
    e2.elements.add(e3);
    var e4 = new Element.html('<tr></tr>');
    e3.elements.add(e4);
    var e5 = new Element.html('<td class="header">User</td>');
    e4.elements.add(e5);
    var e6 = new Element.html('<td class="header">New tweets</td>');
    e4.elements.add(e6);
    var e7 = new Element.html('<td class="header">Last updated</td>');
    e4.elements.add(e7);
    var e8 = new Element.html('<td class="header">Delete</td>');
    e4.elements.add(e8);
    var e9 = new Element.html('<tbody id="dashboard-body"></tbody>');
    e2.elements.add(e9);
  }

  Element get root() => _fragment;

  // CSS class selectors for this template.
  static String get header() => "header";

  // Injection functions:
  // Each functions:

  // With functions:

  // CSS for this template.
  static final String stylesheet = '''
    
.header {
  font-weight: bold;
}

  ''';

  // Stylesheet class selectors:
  String safeHTML(String html) {
    // TODO(terry): Escaping for XSS vulnerabilities TBD.
    return html;
  }
}


// Inject all templates stylesheet once into the head.
bool Dashboard_stylesheet_added = false;
void add_Dashboard_templatesStyles() {
  if (!Dashboard_stylesheet_added) {
    StringBuffer styles = new StringBuffer();

    // All templates stylesheet.
    styles.add(Dashboard.stylesheet);

    Dashboard_stylesheet_added = true;
    document.head.elements.add(new Element.html('<style>${styles.toString()}</style>'));
  }
}
