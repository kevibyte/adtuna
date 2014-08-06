'use strict'

angular.module 'adtunaApp'
.controller('DroneCtrl', [
    '$scope', '$filter', '$http', '$timeout'
    ($scope, $filter, $http, $timeout) ->
        $scope.message = 'Hello'
        # filter
        saveStores = (results) ->
          console.log 'res', results
          $scope.stores = results;
          $scope.loading = false
          init()

        $scope.stores = []
        $scope.searchKeywords = ''
        $scope.filteredStores = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            console.log start
            console.log end
            console.log $scope.currentPageStores
            console.log 'fs', $scope.filteredStores
            $scope.currentPageStores = $scope.filteredStores.slice(start, end)

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
            $scope.filteredStores = $filter('filter')($scope.stores, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            console.log 'orderign---->', rowName
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredStores = $filter('orderBy')($scope.stores, rowName)
            console.log 'filteredstores-->', $scope.filteredStores
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageStores = []

        # init
        init = ->
            $scope.search()
            $scope.select($scope.currentPage)
        saveStores([
          {title:'title',artist:'artist',release_date:'rd',total_tracks:'tt'},
          {title:'title2',artist:'44artist',release_date:'zzrd',total_tracks:'000'},
        ])
        # $http.get('../api/users/').success(saveStores) if $route.current.loadedTemplateUrl.indexOf('user') > -1

])
