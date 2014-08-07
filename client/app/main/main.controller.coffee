'use strict'

angular.module 'adtunaApp'
.controller 'MainCtrl', ($scope, $http, socket) ->
  console.log 'using' , socket
  $scope.awesomeThings = []
  socket.socket.on 'drones:asdf', (drones) ->
     console.log 'drones', drones
  $scope.checkSock = () ->
     console.log('checking...')
     console.log('Socket-->', socket)

  $http.get('/api/things').success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings
    socket.syncUpdates 'thing', $scope.awesomeThings

  $scope.addThing = ->
    return if $scope.newThing is ''
    $http.post '/api/things',
      name: $scope.newThing

    $scope.newThing = ''

  $scope.deleteThing = (thing) ->
    $http.delete '/api/things/' + thing._id

  $scope.$on '$destroy', ->
    socket.unsyncUpdates 'thing'
