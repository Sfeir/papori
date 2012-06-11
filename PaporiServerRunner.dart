#import('dart:io');
#import('package:log4dart/Lib.dart');
#import("./src/server/PaporiServer.dart");

main() {
  var _logger = LoggerFactory.getLogger("main");
  
  var servername = 'Papori';
  var host = '127.0.0.1';
  var port = 8080;
  
  _logger.info("Starting $servername server on $host:$port ...");
  var server = new PaporiServer.get(host, port);
  server.sdkPath = "../..";
  server.packagesPath = "./packages";
  server.start();
  _logger.info("$servername server is running on : http://$host:$port"); 
}