'use strict'

angular.module 'adtunaApp'
.controller 'MainCtrl', ($scope, $http, socket, Auth) ->
  $scope.drones = []
  $scope.drone_requests = []
  boot_drones = () ->
    socket.socket.emit 'get_drones' , $scope.user.email
    socket.socket.on 'drones:'+$scope.user.email , (drones) ->
      return if !drones
      $scope.drones = _.select $scope.drones, (c) -> 
        drones.indexOf(c.ip) is not 1
      $scope.drone_requests = _.difference drones , $scope.drones
      console.log 'drone_requests' , $scope.drone_requests

  $scope.$on '$destroy', ->
    socket.unsyncUpdates 'drone'

  Auth.getUserSync (user) ->
    $scope.user = user
    $http.get('/api/drones').success (drones) ->
      $scope.drones = drones
      socket.syncUpdates 'drone', $scope.drones
      boot_drones()

  isTouchDevice = !!("ontouchstart" of window)
  isIE = !!navigator.userAgent.match(/MSIE/i)
  not isTouchDevice and $("html").addClass("no-touch")
  isIE and $("html").addClass("ie")
  $scope.app =
  name: "AdTuna"
  version: "1.0.0"
  color:
    primary: "#7266ba"
    info: "#23b7e5"
    success: "#27c24c"
    warning: "#fad733"
    danger: "#f05050"
    light: "#e8eff0"
    dark: "#3a3f51"
    black: "#1c2b36"

  settings:
    navbarHeaderColor: "bg-primary"
    navbarCollapseColor: "bg-primary dk"
    asideColor: "bg-black"
    headerFixed: true
    asideFixed: false
    asideFolded: false
