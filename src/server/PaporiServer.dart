#import('dart:io');

/**
* Serveur simple pour l'application.
* Par défaut, les fichiers de l'application sont envoyés tel quel.
* Pour les requêtes commençant pas /twitter/, elles sont redirigées sur le serveur twitter puis le résultat est retourné.
*/
class PaporiServer extends Object {
  HttpServer server;
  String host;
  int port;
  String rootPath;
  
  PaporiServer(String host, int port, [String rootPath = "."]) : server = new HttpServer(), this.host = host, this.port = port, this.rootPath = rootPath {
  }
  
  /**
  * Lance le serveur.
  */
  start(){
    server.listen(host, port);
    server.defaultRequestHandler = staticResquestHandler;
    server.addRequestHandler(twitterMatcher, twitterHandler);
  }
  
  /**
  * Stop le serveur.
  */
  stop(){
    server.close();
  }
  
  /**
  * Récupére les fichiers locaux, retourne une erreur 404 si inexistant, 500 si erreur
  */
  staticResquestHandler(HttpRequest request, HttpResponse response) {
    try{
      File requestedFile = new File("$rootPath${request.path}");
      if(requestedFile.existsSync()){
        print("200 - ${request.path}");
        response.statusCode = 200;
        response.outputStream.write(requestedFile.readAsBytesSync());
      }else {
        print("404 - ${request.path}");
        response.statusCode = 404;
      }
    }
    catch(Exception e){
      print("500 - ${e.toString()}");
      response.statusCode = 500;
    }
    finally{
      response.outputStream.close();
    }
  }
  
  /**
  * Règle de matching pour les requêtes "Twitter" commençant par /twitter/
  */
  bool twitterMatcher(HttpRequest request){
    return request.path.startsWith("/twitter/");
  }
  
  /**
  * Traitement des requêtes "Twitter".
  */
  twitterHandler(HttpRequest request, HttpResponse response){
    // TODO : Faire une requête vers Twitter et retourner le résultat
    // var twitterClient = new HttpClient().open(request.method, "https://api.twitter.com", 443, request.path.substring("/twitter".length));
    
    response.outputStream.write('Hello Twitter, world'.charCodes());
    response.outputStream.close();
  }
}

main() {
  var server = new PaporiServer('127.0.0.1', 8080);
  server.start();
}  