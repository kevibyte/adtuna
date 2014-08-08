'use strict'

angular.module 'adtunaApp'
.config ($stateProvider) ->
  $stateProvider
  .state "access",
    url: "/access"
    template: "<div ui-view class=\"fade-in-right-big smooth\"></div>"
    authenticate: true
  .state "login",
    url: "/login"
    templateUrl: "tpl/page_signin.html"
    controller: 'LoginCtrl'
    authenticate: true
  .state "access.signup",
    url: "/signup"
    templateUrl: "tpl/page_signup.html"
    controller: 'SignupCtrl'
    authenticate: true
  .state "access.forgotpwd",
    url: "/forgotpwd"
    templateUrl: "tpl/page_forgotpwd.html"
    authenticate: true
  .state 'settings',
    url: '/settings'
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsCtrl'
    authenticate: true
