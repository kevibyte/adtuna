'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var DroneSchema = new Schema({
  owner: {type: String, required: true},
  ip: {type: String, required: true},
  active: {type: Boolean, default: true},
  archive: {type: Boolean, default: false},
  created: {type: Date, default: Date.now},
  updated: {type: Date, default: Date.now},
});

module.exports = mongoose.model('Drone', DroneSchema);
