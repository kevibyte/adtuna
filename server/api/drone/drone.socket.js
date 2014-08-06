/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Drone = require('./drone.model');

exports.register = function(socket) {
  Drone.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  Drone.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('drone:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('drone:remove', doc);
}