/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Drone = require('./drone.model')
  , drones = {}

exports.register = function(socket) {
    function add_user(username, type){
      drones[username] = [socket.handshake.address.address]
      socket.broadcast.emit('drones:'+username, drones[username])
    }
    function update_user(username){
      var has_user
      drones[username].map(function(ip){
        if(ip==socket.handshake.address.address) has_user= true;
      })
      if(!has_user) drones[username].push(socket.handshake.address.address)
      socket.broadcast.emit('drones:'+username, drones[username])
    }
    function remove(){
      var r_index;
      drones[socket.ext].map(function(ip, num){
        if(ip==socket.handshake.address.address) r_index= num;
      })
      drones[socket.ext].splice(r_index, 1)
      socket.broadcast.emit('drones:'+socket.ext, drones[socket.ext])
    }
    socket.on('get_drones', function(username){
      console.log('SOMEBODY GETTIN SOME DRONES', username)
      socket.broadcast.emit('drones:'+username, drones[username])
    })
    socket.on('ext_auth', function(username){
      socket.ext = username;
      (drones[username]) ? update_user(username) : add_user(username)
    })
    socket.on('disconnect', function () {
      if(socket.ext) remove(socket);
      console.info('[%s] DISCONNECTED', socket.address);
    });


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
