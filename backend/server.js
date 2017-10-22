require('dotenv').load();
const http = require('http');
const path = require('path');
const AccessToken = require('twilio').jwt.AccessToken;
const ChatGrant = AccessToken.ChatGrant;
const express = require('express');
// Create Express webapp
const app = express();

var bodyParser = require('body-parser');
var mongoose = require('mongoose');
mongoose.Promise = global.Promise;
var db = mongoose.connect('mongodb://localhost/chale');

var Event = require('./model/event');
var User = require('./model/users')


app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

/*
Generate an Access Token for a chat application user - it generates a random
username for the client requesting a token, and takes a device ID as a query
parameter.
*/
app.get('/token', (request, response) => {
  const appName = 'Chale';
  const identity = request.query.id;
  const deviceId = request.query.device;

  // Create a unique ID for the client on their current device
  const endpointId = appName + ':' + identity + ':' + deviceId;

  // Create a "grant" which enables a client to use Chat as a given user,
  // on a given device
  const chatGrant = new ChatGrant({
    serviceSid: "IS67f535d1825d420c85a481139c9a0292",
    endpointId: endpointId,
  });

  // Create an access token which we will sign and return to the client,
  // containing the grant we just created
  const token = new AccessToken(
    "ACfb470ec053f114090b4af2fd02195e38",
    "SKb44c93e4eecf5e4568135865b5782d7c",
    "FIY4j33ZH0PWyt5QNlUZBPJRf4jVrrl0"
  );
  token.addGrant(chatGrant);
  token.identity = identity;

  // Serialize the token to a JWT string and include it in a JSON response
  response.send({
    identity: identity,
    token: token.toJwt(),
  });
});


app.get('/events', function(req, res){
    Event.find({}, function(err, events){
        if(err){
            res.status(500).send({error: "Could not fetch events"});
        } else{
            res.send({"result": events});
        }
    })
})

app.post('/add_event', function(req,res){
    var event = new Event();
    event.title = req.body.title;
    event.datetime = req.body.datetime;
    event.people = req.body.people;
    event.location = req.body.location;
    
    event.save(function(err, newEvent){
        if(err){
            res.status(500).send({error: "Could add event"});
        } else{
            res.send({"result": newEvent});
        }
    })
})

app.post('/join_event', function(req,res){
    Event.findOne({title: req.body.event_title}, function(err, event)
    {
        if(err){
            res.status(500).send({error: "Could not find event"})
        }
        else{
            event.people.push(req.body.user_name);
            event.save(function(err, newEvent){
                if(err){
                    res.status(500).send({error: "Could not update event"})
                }else{
                    res.send({"result": newEvent});
                }
            })
        }
    })
})

app.post('/add_user', function(req,res){
    var user = new User();
    user.username = req.body.username;
    
    user.save(function(err, newUser){
        if(err){
            res.status(500).send({error: "Could add event"});
        } else{
            res.send({"result": newUser});
        }
    })
})

// Create http server and run it
const server = http.createServer(app);
const port = process.env.PORT || 3000;
server.listen(port, () => {
  console.log('Express server running on *:' + port);
});
