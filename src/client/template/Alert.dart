// Generated Dart class from HTML template.
// DO NOT EDIT.

class Alert {
  Map<String, Object> _scopes;
  
  // sthis is what your template hangs off of. This never touches the DOM.
  Element _fragment;

  String header;
  String message;
  String type;

  // this name comes from the template
  Alert(this.header, this.message, this.type) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    // templates can inject stylesheets. Example to follow.
    add_Alert_templatesStyles();

    // here's the template! Notice the string interpolation
    _fragment = new DocumentFragment();
    var e0 = new Element.html('<div class="alert ${type}"></div>');
    _fragment.elements.add(e0);
    var e1 = new Element.html('<a data-dismiss="alert" href="#" class="close">×</a>');
    e0.elements.add(e1);
    var e2 = new Element.html('<h4 class="alert-heading">${inject_0()}</h4>');
    e0.elements.add(e2);
    var e3 = new Element.html('<p>${inject_1()}</p>');
    e0.elements.add(e3);
  }

  // how to access the nodes from the template.
  // Still not attached to DOM.
  Element get root() => _fragment;

  // Injection functions:
  String inject_0() {
    return safeHTML('${header}');
  }

  String inject_1() {
    return safeHTML('${message}');
  }

  // Each functions:

  // With functions:

  // CSS for this template.
  // our template didn't define any CSS, so this is empty
  static final String stylesheet = "";
  String safeHTML(String html) {
    // TODO(terry): Escaping for XSS vulnerabilities TBD.
    return html;
  }
}


// Inject all templates stylesheet once into the head.
bool Alert_stylesheet_added = false;
void add_Alert_templatesStyles() {
  if (!Alert_stylesheet_added) {
    StringBuffer styles = new StringBuffer();

    // All templates stylesheet.
    styles.add(Alert.stylesheet);

    Alert_stylesheet_added = true;
    document.head.elements.add(new Element.html('<style>${styles.toString()}</style>'));
  }
}
