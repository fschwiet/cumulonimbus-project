
var path = require("path");
var http = require('http');

var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Hello World\nrequest.url: " + request.url + "\ncwd: " + path.resolve(".") + "\nheaders: " + JSON.stringify(request.headers));
});

// Listen on port 8088, IP defaults to 127.0.0.1
server.listen(8088);

// Put a friendly message on the terminal
console.log("Server running at http://*:8088/");

