'use strict'

angular.module 'adtunaApp'
.config ($stateProvider) ->
  $stateProvider.state 'app.page.drone',
    url: '/drone'
    templateUrl: 'app/drone/drone.html'
    controller: 'DroneCtrl'
