#import('dart:io');

/**
* Serveur simple pour l'application.
* Par défaut, les fichiers de l'application sont envoyés tel quel.
* Pour les requêtes commençant pas /twitter/, elles sont redirigées sur le serveur twitter puis le résultat est retourné.
* Pour les requêtes commençant pas /dart-editor/, elles sont redirigées sur les fichiers du SDK (pour les tests)
*/
class PaporiServer extends Object {
  static final String _TWEETER_PATH_PREFIX = '/twitter';
  static final String _DART_EDITOR_PATH_PREFIX = '/dart-editor';
  
  HttpServer _server;
  String _host;
  int _port;
  String _rootPath;
  String _sdkPath;
  String _twitterApiUrl = "api.twitter.com";
  int _twitterApiPort = 80;
  
  PaporiServer(String host, int port, [String rootPath = '.']) 
  : 
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
    _server.addRequestHandler(_dartEditorMatcher, _dartEditorHandler);
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
  * Renvoit les données du fichier passé en paramétre
  */
  _fileResponse(HttpRequest request, HttpResponse response, String filePath){
    _exceptionHandler(request, response, () {
      File requestedFile = new File(filePath);
      if(requestedFile.existsSync()){
        response.statusCode = 200;
        response.outputStream.write(requestedFile.readAsBytesSync());
      }else {
        response.statusCode = 404;
      }
      print("${response.statusCode} - ${request.path}");
      response.outputStream.close();
    });
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
      print("${request.method} - http://$_twitterApiUrl$path");
  
      // TODO : améliorer cette partie en recopiant les entêtes, cookies, ... principe d'un reverse proxy
      var twitterClient = new HttpClient().open(request.method, _twitterApiUrl, _twitterApiPort, path);
      twitterClient.onResponse = (HttpClientResponse twitterResponse){
        twitterResponse.inputStream.pipe(response.outputStream, true);
      };
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

  _exceptionHandler(HttpRequest request, HttpResponse response, unsafeRun()){
    try{
      unsafeRun();
    }
    catch(Exception e){
      print("500 - ${request.path} - ${e.toString()}");
      response.statusCode = 500;
      response.outputStream.close();
    }
  }
  
  set twitterApiUrl(String value) => _twitterApiUrl = value;
  set twitterApiPort(int value) => _twitterApiPort = value;
  set sdkPath(String value) => _sdkPath = value;
}

main() {
  var server = new PaporiServer('127.0.0.1', 8080);
  server.sdkPath = "../..";
  server.start();
}  