var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var users = new Schema({
    username: String
});

module.exports = mongoose.model('User',users);