#import('dart:io');
#import("./src/server/PaporiServer.dart");

main() {
  var servername = 'Papori';
  var host = '127.0.0.1';
  var port = 8080;
  
  print("Starting $servername server on $host:$port ...");
  var server = new PaporiServer(host, port);
  server.sdkPath = "../..";
  server.packagesPath = "./packages";
  server.start();
  print("$servername server is running on : http://$host:$port"); 
}