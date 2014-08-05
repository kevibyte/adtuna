'use strict'

app = angular.module 'adtunaApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'btford.socket-io',
  'ui.router',
  'ui.bootstrap',
  'ngAnimate',
  'ui.load',
  'ui.jq',
  'ui.validate',
  'app.filters',
  'app.services',
  'app.directives',
  'app.controllers'
]
.run ($rootScope, $state, $stateParams, $location, Auth) ->
  $rootScope.$state = $state;
  $rootScope.$stateParams = $stateParams;        
  # Redirect to login if route requires auth and you're not logged in
  $rootScope.$on '$stateChangeStart', (event, next) ->
    Auth.isLoggedInAsync (loggedIn) ->
      $location.path "/login" if next.authenticate and not loggedIn
.factory 'authInterceptor', ($rootScope, $q, $cookieStore, $location) ->
  # Add authorization token to headers
  request: (config) ->
      config.headers = config.headers or {}
      config.headers.Authorization = 'Bearer ' + $cookieStore.get 'token' if $cookieStore.get 'token'
      config
    # Intercept 401s and redirect you to login
    responseError: (response) ->
      if response.status is 401
        $location.path '/login'
        # remove any stale tokens
        $cookieStore.remove 'token'
      $q.reject response
.config ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider, $controllerProvider, $compileProvider, $filterProvider, $provide) ->
  app.controller = $controllerProvider.register;
  app.directive  = $compileProvider.directive;
  app.filter     = $filterProvider.register;
  app.factory    = $provide.factory;
  app.service    = $provide.service;
  app.constant   = $provide.constant;
  $locationProvider.html5Mode true
  $httpProvider.interceptors.push 'authInterceptor'
  $urlRouterProvider.otherwise "/app/dashboard"
.constant "JQ_CONFIG",
  easyPieChart: ["js/jquery/charts/easypiechart/jquery.easy-pie-chart.js"]
  sparkline: ["js/jquery/charts/sparkline/jquery.sparkline.min.js"]
  plot: [
    "js/jquery/charts/flot/jquery.flot.min.js"
    "js/jquery/charts/flot/jquery.flot.resize.js"
    "js/jquery/charts/flot/jquery.flot.tooltip.min.js"
    "js/jquery/charts/flot/jquery.flot.spline.js"
    "js/jquery/charts/flot/jquery.flot.orderBars.js"
    "js/jquery/charts/flot/jquery.flot.pie.min.js"
  ]
  slimScroll: ["js/jquery/slimscroll/jquery.slimscroll.min.js"]
  sortable: ["js/jquery/sortable/jquery.sortable.js"]
  nestable: [
    "js/jquery/nestable/jquery.nestable.js"
    "js/jquery/nestable/nestable.css"
  ]
  filestyle: ["js/jquery/file/bootstrap-filestyle.min.js"]
  slider: [
    "js/jquery/slider/bootstrap-slider.js"
    "js/jquery/slider/slider.css"
  ]
  chosen: [
    "js/jquery/chosen/chosen.jquery.min.js"
    "js/jquery/chosen/chosen.css"
  ]
  TouchSpin: [
    "js/jquery/spinner/jquery.bootstrap-touchspin.min.js"
    "js/jquery/spinner/jquery.bootstrap-touchspin.css"
  ]
  wysiwyg: [
    "js/jquery/wysiwyg/bootstrap-wysiwyg.js"
    "js/jquery/wysiwyg/jquery.hotkeys.js"
  ]
  dataTable: [
    "js/jquery/datatables/jquery.dataTables.min.js"
    "js/jquery/datatables/dataTables.bootstrap.js"
    "js/jquery/datatables/dataTables.bootstrap.css"
  ]
  vectorMap: [
    "js/jquery/jvectormap/jquery-jvectormap.min.js"
    "js/jquery/jvectormap/jquery-jvectormap-world-mill-en.js"
    "js/jquery/jvectormap/jquery-jvectormap-us-aea-en.js"
    "js/jquery/jvectormap/jquery-jvectormap.css"
  ]
