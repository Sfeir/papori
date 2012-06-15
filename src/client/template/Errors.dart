// Generated Dart class from HTML template.
// DO NOT EDIT.

class Errors {
  Map<String, Object> _scopes;
  Element _fragment;

  String header;
  List errors;
  String type;

  Errors(this.header, this.errors, this.type) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_Errors_templatesStyles();

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
    var e5 = new Element.html('<ul>');
    e2.elements.add(e5);
    each_0(errors, e5);
  }

  Element get root() => _fragment;

  // Injection functions:
  String inject_0() {
    return safeHTML('${header}');
  }

  String inject_1() {
    // Local scoped block names.
    var error = _scopes["error"];

    return safeHTML('${error.title}');
  }

  String inject_2() {
    // Local scoped block names.
    var error = _scopes["error"];

    return safeHTML('${error.message}');
  }

  // Each functions:
  each_0(List items, Element parent) {
    for (var error in items) {
      _scopes["error"] = error;
      var e0 = new Element.html('<li>${inject_1()}>${inject_2()}</li>');
      parent.elements.add(e0);
      _scopes.remove("error");
    }
  }


  // With functions:

  // CSS for this template.
  static final String stylesheet = "";
  String safeHTML(String html) {
    // TODO(terry): Escaping for XSS vulnerabilities TBD.
    return html;
  }
}


// Inject all templates stylesheet once into the head.
bool Errors_stylesheet_added = false;
void add_Errors_templatesStyles() {
  if (!Errors_stylesheet_added) {
    StringBuffer styles = new StringBuffer();

    // All templates stylesheet.
    styles.add(Errors.stylesheet);

    Errors_stylesheet_added = true;
    document.head.elements.add(new Element.html('<style>${styles.toString()}</style>'));
  }
}
