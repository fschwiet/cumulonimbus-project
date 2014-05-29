
var path = require("path");
var http = require('http');

var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Hello World\nrequest.url: " + request.url + "\ncwd: " + path.resolve("."));
});

// Listen on port 8000, IP defaults to 127.0.0.1
server.listen(8080);

// Put a friendly message on the terminal
console.log("Server running at http://*:8080/");

function showStatus() {
	console.log("running...");

	setInterval(showStatus, 60 * 1000);
}

showStatus();

