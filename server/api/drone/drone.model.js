'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var DroneSchema = new Schema({
  owner: String,
  ip: String,
  active: Boolean
});

module.exports = mongoose.model('Drone', DroneSchema);
