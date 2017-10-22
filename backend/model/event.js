var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var event = new Schema({
    title: String,
    people: [{type: String}],
    datetime: String,
    location: String,
});

module.exports = mongoose.model('Event', event);