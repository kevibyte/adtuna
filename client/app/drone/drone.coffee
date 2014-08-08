'use strict'

angular.module 'adtunaApp'
.config ($stateProvider) ->
  $stateProvider
    .state 'app.drone',
      url: '/drone'
      template: "<div ui-view class=\"fade-in-down\"></div>"
      authenticate: true
    .state 'app.drone.list',
      url: '/list'
      templateUrl: 'app/drone/drone.html'
      controller: 'DroneCtrl'
      authenticate: true
    .state 'app.drone.edit',
      url: "/{ip}"
      templateUrl: 'app/drone/drone.html'
      controller: 'DroneCtrl'
      authenticate: true

