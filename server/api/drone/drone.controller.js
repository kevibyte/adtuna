'use strict';

var _ = require('lodash');
var Drone = require('./drone.model');

// Get list of drones
exports.index = function(req, res) {
  Drone.find(function (err, drones) {
    if(err) { return handleError(res, err); }
    return res.json(200, drones);
  });
};

// Get a single drone
exports.show = function(req, res) {
  Drone.findById(req.params.id, function (err, drone) {
    if(err) { return handleError(res, err); }
    if(!drone) { return res.send(404); }
    return res.json(drone);
  });
};

// Creates a new drone in the DB.
exports.create = function(req, res) {
  Drone.create(req.body, function(err, drone) {
    if(err) { return handleError(res, err); }
    return res.json(201, drone);
  });
};

// Updates an existing drone in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Drone.findById(req.params.id, function (err, drone) {
    if (err) { return handleError(res, err); }
    if(!drone) { return res.send(404); }
    var updated = _.merge(drone, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.json(200, drone);
    });
  });
};

// Deletes a drone from the DB.
exports.destroy = function(req, res) {
  Drone.findById(req.params.id, function (err, drone) {
    if(err) { return handleError(res, err); }
    if(!drone) { return res.send(404); }
    drone.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.send(204);
    });
  });
};

function handleError(res, err) {
  return res.send(500, err);
}
