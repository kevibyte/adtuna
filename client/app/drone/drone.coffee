'use strict'

angular.module 'adtunaApp'
.config ($stateProvider) ->
  $stateProvider
    .state 'app.drone',
      abstract:true
      url: '/drone'
      template: "<div ui-view class=\"fade-in-down\"></div>"
    .state 'app.drone.list',
      url: '/list'
      templateUrl: 'app/drone/drone.html'
      controller: 'DroneCtrl'
    .state 'app.drone.edit',
      url: "/{droneid}"
      templateUrl: 'app/drone/drone.html'
      controller: 'DroneCtrl'

