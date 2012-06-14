#library('server');

#import('dart:io');
#import('dart:uri');
#import('dart:json');
#import('package:log4dart/Lib.dart');

/**
* Serveur simple pour l'application.
* Par défaut, les fichiers de l'application sont envoyés tel quel.
* Pour les requêtes commençant pas /twitter/, elles sont redirigées sur le serveur twitter puis le résultat est retourné.
* Pour les requêtes commençant pas /dart-editor/, elles sont redirigées sur les fichiers du SDK (pour les tests)
*/
class PaporiServer {
  final Logger _logger;
  
  static final String _TWEETER_PATH_PREFIX = '/twitter';
  static final String _PAPORI_PATH_PREFIX = '/papori';
  static final String _DART_EDITOR_PATH_PREFIX = '/dart-editor';
  static final String _PACKAGES_PATH_PREFIX = '/test/packages';
  
  HttpServer _server;
  String _host;
  int _port;
  String _rootPath;
  String _sdkPath;
  String _packagesPath;
  String _twitterApiUrl = 'api.twitter.com';
  int _twitterApiPort = 80;
  List<String> _indexFiles = const ['index.html'];
  
  PaporiServer() : _logger = LoggerFactory.getLogger("PaporiServer");
  
  PaporiServer.get(String host, int port, [String rootPath = '.']) 
  : 
    _logger = LoggerFactory.getLogger("PaporiServer"),
    _server = new HttpServer(), 
    this._host = host, 
    this._port = port, 
    this._rootPath = rootPath,
    this._sdkPath = '.'
  {
  }
  
  /**
  * Lance le serveur.
  */
  start(){
    _server.listen(_host, _port);
    _server.defaultRequestHandler = _staticResquestHandler;
    _server.addRequestHandler(_twitterMatcher, _twitterHandler);
    _server.addRequestHandler(_paporiMatcher, _paporiHandler);
    _server.addRequestHandler(_dartEditorMatcher, _dartEditorHandler);
    _server.addRequestHandler(_packagesMatcher, _packagesHandler);
  }
  
  /**
  * Stop le serveur.
  */
  stop(){
    _server.close();
  }
  
  /**
  * Récupére les fichiers locaux, retourne une erreur 404 si inexistant, 500 si erreur
  */
  _staticResquestHandler(HttpRequest request, HttpResponse response) {
    _fileResponse(request, response, "$_rootPath${request.path}");
  }
  
  /**
  * Règle de matching pour les requêtes "Twitter" commençant par /twitter/
  */
  bool _twitterMatcher(HttpRequest request){
    return request.path.startsWith("$_TWEETER_PATH_PREFIX/");
  }
  
  /**
  * Traitement des requêtes "Twitter".
  */
  _twitterHandler(HttpRequest request, HttpResponse response){
    _exceptionHandler(request, response, () {
      var path = request.path.substring(_TWEETER_PATH_PREFIX.length);
      _logger.debug("${request.method} - http://$_twitterApiUrl$path");
  
      HttpClientConnection client = new HttpClient().open(request.method, _twitterApiUrl, _twitterApiPort, path);
      _proxify(request, response, client);
    });
  }
  
  /*****************************************************
   *          PAPORI MATCHER & HANDLER                 *
   *****************************************************/
  
  bool _paporiMatcher(HttpRequest request){
    return request.path.startsWith("$_PAPORI_PATH_PREFIX/");
  }
  
  _paporiHandler(HttpRequest request, HttpResponse response){
    _exceptionHandler(request, response, () {
      Map data = new Map(); // create a map for the response
      print("Request for ${request.path}");
      data["get"] = request.path; // add the path to the data
      String responseData = JSON.stringify(data); // convert the map to JSON
      response.outputStream.writeString(responseData); // send the data back to the client
      response.outputStream.close(); // close the response
    });
  }
  
  /**
  * Règle de matching pour les requêtes de test commençant par /dart-editor/
  */
  bool _dartEditorMatcher(HttpRequest request){
    return request.path.startsWith("$_DART_EDITOR_PATH_PREFIX/");
  }
  
  /**
  * Traitement des requêtes "Twitter".
  */
  _dartEditorHandler(HttpRequest request, HttpResponse response){
    _fileResponse(request, response, "$_sdkPath${request.path}");
  }
  
  /**
  * Règle de matching pour les requêtes de test commençant par /test/packages/
  */
  bool _packagesMatcher(HttpRequest request){
    return request.path.startsWith("$_PACKAGES_PATH_PREFIX/");
  }
  
  /**
  * Traitement des requêtes "Twitter".
  */
  _packagesHandler(HttpRequest request, HttpResponse response){
    var path = request.path.substring(_PACKAGES_PATH_PREFIX.length);
    _fileResponse(request, response, "$_packagesPath$path");
  }
  
  /**
  * Renvoit les données du fichier passé en paramétre
  */
  _fileResponse(HttpRequest request, HttpResponse response, String filePath){
    _exceptionHandler(request, response, () {
      File requestedFile = new File(filePath);

      // Recherche d'une page index si l'url se termine par un /
      if(filePath.endsWith('/')){
        var filesIterator = _indexFiles.map((indexFile) => new File("$filePath$indexFile")).filter((file) => file.existsSync()).iterator();
        if(filesIterator.hasNext()){
          requestedFile = filesIterator.next();
        }
      }

      // On vérifie si le fichier existe
      if(requestedFile.existsSync()){
        response.statusCode = 200;
        requestedFile.openInputStream().pipe(response.outputStream, true);
        _logger.debug("${response.statusCode} - ${request.path} - ${requestedFile.fullPathSync()}");
      } else {
        response.statusCode = 404;
        response.outputStream.close();
        _logger.debug("${response.statusCode} - ${request.path}}");
      }
    });
  }

  /**
  * Récupère les exceptions lancés par la fonction unsafeRun et retourne une erreur 500 s'il y a.
  */
  _exceptionHandler(HttpRequest request, HttpResponse response, unsafeRun()){
    try{
      unsafeRun();
    }
    catch(Exception e){
      _logger.error("500 - ${request.path} - $e");
      response.statusCode = 500;
      response.outputStream.close();
    }
  }
  
  /**
  * Redirige la requête vers une connexion ouverte et redirige la réponse de celle-ci
  */
  _proxify(HttpRequest request, HttpResponse response, HttpClientConnection client){
    client.onRequest = (HttpClientRequest clientRequest) {
//        print("-------------request----------------");
//        print("HEADERS : \n${request.headers}");
//        print("contentLength : ${request.contentLength}");
//        print("------------------------------------");
      
      request.headers.forEach((String name, List<String> values) => ['host'].every((n) => n != name) ?  values.forEach((value) => clientRequest.headers.add(name, value)) : '');
      clientRequest.contentLength = request.contentLength;

//      print("-----------clientRequest------------");
//      print("HEADERS : \n${clientRequest.headers}");
//      print("contentLength : ${clientRequest.contentLength}");
//      print("------------------------------------");

      if(request.contentLength > 0){
        request.inputStream.pipe(clientRequest.outputStream, true);
      } else {
        clientRequest.outputStream.close();
      }
    };
    client.onResponse = (HttpClientResponse clientResponse){
      _exceptionHandler(request, response, () {
//        print("-----------clientResponse-----------");
//        print("HEADERS : \n${clientResponse.headers}");
//        print("contentLength : ${clientResponse.contentLength}");
//        print("reasonPhrase : ${clientResponse.reasonPhrase}");
//        print("statusCode : ${clientResponse.statusCode}");
//        print("------------------------------------");
        
        clientResponse.headers.forEach((String name, List<String> values) => values.forEach((value) => response.headers.add(name, value)));
        response.contentLength = clientResponse.contentLength;
        response.reasonPhrase = clientResponse.reasonPhrase;
        response.statusCode = clientResponse.statusCode;
        
//        print("-------------response---------------");
//        print("HEADERS : \n${response.headers}");
//        print("contentLength : ${response.contentLength}");
//        print("reasonPhrase : ${response.reasonPhrase}");
//        print("statusCode : ${response.statusCode}");
//        print("------------------------------------");

        if(clientResponse.contentLength > 0) {
          clientResponse.inputStream.pipe(response.outputStream, true);
        } else {
          response.outputStream.close();
        }
      });
    };
  }
  
  set twitterApiUrl(String value) => _twitterApiUrl = value;
  set twitterApiPort(int value) => _twitterApiPort = value;
  set sdkPath(String value) => _sdkPath = value;
  set packagesPath(String value) => _packagesPath = value;
}
