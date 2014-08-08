'use strict'

angular.module 'adtunaApp'
.config ($stateProvider) ->
  $stateProvider
  .state "app",
    abstract: true
    url: "/app"
    templateUrl: "tpl/app.html"
  .state "app.dashboard",
    url: "/dashboard"
    templateUrl: "tpl/app_dashboard.html"
    controller: 'MainCtrl'
    authenticate: true
  .state "app.page",
    url: "/page"
    template: "<div ui-view class=\"fade-in-down\"></div>"
    authenticate: true
  .state "app.page.profile",
    url: "/profile"
    templateUrl: "tpl/page_profile.html"
    authenticate: true
  .state 'app.settings',
    url: '/settings'
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsCtrl'
    authenticate: true
