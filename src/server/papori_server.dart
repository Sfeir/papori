#library('server');

#import('dart:io');
#import('dart:uri');
#import('dart:json');
#import('package:log4dart/lib.dart');

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

  final String host = '127.0.0.1';
  final int port = 8080;
  final String rootPath = '.';
  final HttpServer _server;

  String twitterApiUrl = 'api.twitter.com';
  int twitterApiPort = 80;
  List<String> indexFiles = const ['index.html'];

  PaporiServer.get(String this.host, int this.port, [String this.rootPath = '.'])
  :
    _logger = LoggerFactory.getLogger("PaporiServer"),
    _server = new HttpServer()
  {
  }

  /**
  * Lance le serveur.
  */
  start(){
    _server.listen(host, port);
    _server.defaultRequestHandler = _staticResquestHandler;
    _server.addRequestHandler(_twitterMatcher, _twitterHandler);
    _server.addRequestHandler(_paporiMatcher, _paporiHandler);
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
    _fileResponse(request, response, "$rootPath${request.path}");
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
      _logger.info("${request.method} - http://$twitterApiUrl$path");

      HttpClientConnection client = new HttpClient().open(request.method, twitterApiUrl, twitterApiPort, path);
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
      data["get"] = request.path; // add the path to the data
      String responseData = JSON.stringify(data); // convert the map to JSON
      response.statusCode = 200;
      response.outputStream.writeString(responseData); // send the data back to the client
      response.outputStream.close(); // close the response
      _logger.info("${response.statusCode} - ${request.path}}");
    });
  }

  /**
  * Renvoit les données du fichier passé en paramétre
  */
  _fileResponse(HttpRequest request, HttpResponse response, String filePath){
    _exceptionHandler(request, response, () {
      File requestedFile = new File(filePath);

      // Recherche d'une page index si l'url se termine par un /
      if(filePath.endsWith('/')){
        var filesIterator = indexFiles.map((indexFile) => new File("$filePath$indexFile")).filter((file) => file.existsSync()).iterator();
        if(filesIterator.hasNext()){
          requestedFile = filesIterator.next();
        }
      }

      // On vérifie si le fichier existe
      if(requestedFile.existsSync()){
        response.statusCode = 200;
        response.contentLength = requestedFile.lengthSync();
        requestedFile.openInputStream().pipe(response.outputStream, true);
        _logger.info("${response.statusCode} - ${request.path} - ${requestedFile.fullPathSync()}");
      } else {
        response.statusCode = 404;
        response.outputStream.close();
        _logger.info("${response.statusCode} - ${request.path}}");
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

      _logHttpRequest("request", request);

      request.headers.forEach((String name, List<String> values) =>
          'host' != name.toLowerCase() ?
              values.forEach((value) => clientRequest.headers.add(name, value))
              : null);
      clientRequest.contentLength = request.contentLength;

      _logHttpRequest("clientRequest", clientRequest);

      if(request.contentLength > 0){
        request.inputStream.pipe(clientRequest.outputStream, true);
      } else {
        clientRequest.outputStream.close();
      }
    };
    client.onResponse = (HttpClientResponse clientResponse){
      _exceptionHandler(request, response, () {
        _logHttpResponse("clientResponse", clientResponse);

        clientResponse.headers.forEach((String name, List<String> values) => values.forEach((value) => response.headers.add(name, value)));
        response.contentLength = clientResponse.contentLength;
        response.reasonPhrase = clientResponse.reasonPhrase;
        response.statusCode = clientResponse.statusCode;

        _logHttpResponse("response", response);

        if(clientResponse.contentLength > 0) {
          clientResponse.inputStream.pipe(response.outputStream, true);
        } else {
          response.outputStream.close();
        }
      });
    };
  }

  _logHttpRequest(String name, request){
    _logger.debug("\n------------- $name ----------------\n"
      "contentLength : ${request.contentLength}\n"
    "HEADERS : \n${request.headers}\n"
    "------------------------------------\n");
  }

  _logHttpResponse(String name, response){
    _logger.debug("\n------------- $name ----------------\n"
      "statusCode : ${response.statusCode}\n"
    "reasonPhrase : ${response.reasonPhrase}\n"
    "contentLength : ${response.contentLength}\n"
    "HEADERS : \n${response.headers}\n"
    "------------------------------------\n");
  }
}
