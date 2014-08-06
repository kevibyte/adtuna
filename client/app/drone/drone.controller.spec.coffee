'use strict'

describe 'Controller: DroneCtrl', ->

  # load the controller's module
  beforeEach module 'adtunaApp'
  DroneCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DroneCtrl = $controller 'DroneCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
