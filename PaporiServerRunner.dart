#import('dart:io');
#import("./src/server/PaporiServer.dart");
#import('package:log4dart/lib.dart');

main() {
  var _logger = LoggerFactory.getLogger("main");

  var servername = 'Papori';
  var host = '127.0.0.1';
  var port = 8080;
  var root = new File(new Options().script).directorySync().path;

  _logger.info("Starting $servername server on $host:$port ...");
  _logger.info("Root directory: root");
  var server = new PaporiServer.get(host, port, root);
  server.sdkPath = "../..";
  server.packagesPath = "./packages";
  server.start();
  _logger.info("$servername server is running on : http://$host:$port");
}