// Generated Dart class from HTML template.
// DO NOT EDIT.

class Alert {
  Map<String, Object> _scopes;
  Element _fragment;

  String header;
  String message;
  String type;

  Alert(this.header, this.message, this.type) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_Alert_templatesStyles();

    _fragment = new DocumentFragment();
    var e0 = new Element.html('<div class="row"></div>');
    _fragment.elements.add(e0);
    var e1 = new Element.html('<div class="span12"></div>');
    e0.elements.add(e1);
    var e2 = new Element.html('<div class="alert ${type}"></div>');
    e1.elements.add(e2);
    var e3 = new Element.html('<a data-dismiss="alert" href="#" class="close">×</a>');
    e2.elements.add(e3);
    var e4 = new Element.html('<h4 class="alert-heading">${inject_0()}</h4>');
    e2.elements.add(e4);
    var e5 = new Element.html('<p>${inject_1()}</p>');
    e2.elements.add(e5);
  }

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
