'use strict'

angular.module 'adtunaApp'
.controller('DroneCtrl', [
    '$stateParams', '$scope', '$filter', '$http', '$timeout'
    ($stateParams, $scope, $filter, $http, $timeout) ->

      colors = ['bg-danger', 'bg-warning', 'bg-success', 'bg-info', 'bg-primary', 'bg-black', 'bg-dark', 'bg-light']
      hype = ['dk', 'dker', 'bg', 'lt', 'lter']
      $scope.color = colors[Math.floor(Math.random()*colors.length)]+' '+hype[Math.floor(Math.random()*hype.length)]
      fill_drone = (drone)->
        $scope.have_drone = true
        $scope.drone = drone[0]
      $http.get('/api/drones/ip/'+$stateParams.ip).success(fill_drone) if $stateParams.ip
      $scope.addDrone = (drone, ind)->
        $scope.drone_requests.splice(ind, 1)
        console.log 'adding drone' , drone
        return if drone is ''
        $http.post '/api/drones',
          owner: $scope.user.email
          ip: drone
      $scope.deleteDrone = (drone) ->
        $http.delete '/api/drones/' + drone._id
      # filter
      printRows = (results) ->
        console.log 'saving', results
        $scope.rows = results;
        $scope.loading = false
        init()

      $scope.rows = []
      $scope.searchKeywords = ''
      $scope.filtered = []
      $scope.row = ''

      $scope.select = (page) ->
          start = (page - 1) * $scope.numPerPage
          end = start + $scope.numPerPage
          $scope.tableResults = $scope.filtered.slice(start, end)

      # on page change: change numPerPage, filtering string
      $scope.onFilterChange = ->
          $scope.select(1)
          $scope.currentPage = 1
          $scope.row = ''

      $scope.onNumPerPageChange = ->
          $scope.select(1)
          $scope.currentPage = 1

      $scope.onOrderChange = ->
          $scope.select(1)
          $scope.currentPage = 1


      $scope.search = ->
          $scope.filtered = $filter('filter')($scope.rows, $scope.searchKeywords)
          $scope.onFilterChange()

      # orderBy
      $scope.order = (rowName)->
          if $scope.row == rowName
              return
          $scope.row = rowName
          $scope.filtered = $filter('orderBy')($scope.rows, rowName)
          $scope.onOrderChange()

      # pagination
      $scope.numPerPageOpt = [3, 5, 10, 20]
      $scope.numPerPage = $scope.numPerPageOpt[2]
      $scope.currentPage = 1
      $scope.tableResults = []

      # init
      init = ->
          $scope.search()
          $scope.select($scope.currentPage)

      printRows($scope.drones)
])
.controller('DroneEditCtrl', [
  '$stateParams', '$scope', '$filter', '$http', '$timeout'
  ($stateParams, $scope, $filter, $http, $timeout) ->
])
