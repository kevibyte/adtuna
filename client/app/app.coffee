'use strict'

angular.module 'adtunaApp', [
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

.config ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider, $controllerProvider, $compileProvider, $filterProvider, $provide) ->
  app.controller = $controllerProvider.register;
  app.directive  = $compileProvider.directive;
  app.filter     = $filterProvider.register;
  app.factory    = $provide.factory;
  app.service    = $provide.service;
  app.constant   = $provide.constant;

  $urlRouterProvider.otherwise "/app/dashboard"
  $stateProvider.state("app",
    abstract: true
    url: "/app"
    templateUrl: "tpl/app.html"
  ).state("app.dashboard",
    url: "/dashboard"
    templateUrl: "tpl/app_dashboard.html"
  ).state("app.ui",
    url: "/ui"
    template: "<div ui-view class=\"fade-in-up\"></div>"
  ).state("app.ui.buttons",
    url: "/buttons"
    templateUrl: "tpl/ui_buttons.html"
  ).state("app.ui.icons",
    url: "/icons"
    templateUrl: "tpl/ui_icons.html"
  ).state("app.ui.grid",
    url: "/grid"
    templateUrl: "tpl/ui_grid.html"
  ).state("app.ui.widgets",
    url: "/widgets"
    templateUrl: "tpl/ui_widgets.html"
  ).state("app.ui.bootstrap",
    url: "/bootstrap"
    templateUrl: "tpl/ui_bootstrap.html"
  ).state("app.ui.sortable",
    url: "/sortable"
    templateUrl: "tpl/ui_sortable.html"
  ).state("app.ui.portlet",
    url: "/portlet"
    templateUrl: "tpl/ui_portlet.html"
  ).state("app.ui.timeline",
    url: "/timeline"
    templateUrl: "tpl/ui_timeline.html"
  ).state("app.ui.jvectormap",
    url: "/jvectormap"
    templateUrl: "tpl/ui_jvectormap.html"
  ).state("app.ui.chart",
    url: "/chart"
    templateUrl: "tpl/ui_chart.html"
  ).state("app.table",
    url: "/table"
    template: "<div ui-view></div>"
  ).state("app.table.static",
    url: "/static"
    templateUrl: "tpl/table_static.html"
  ).state("app.table.datatable",
    url: "/datatable"
    templateUrl: "tpl/table_datatable.html"
  ).state("app.form",
    url: "/form"
    template: "<div ui-view class=\"fade-in\"></div>"
  ).state("app.form.elements",
    url: "/elements"
    templateUrl: "tpl/form_elements.html"
  ).state("app.form.validation",
    url: "/validation"
    templateUrl: "tpl/form_validation.html"
  ).state("app.form.wizard",
    url: "/wizard"
    templateUrl: "tpl/form_wizard.html"
  ).state("app.page",
    url: "/page"
    template: "<div ui-view class=\"fade-in-down\"></div>"
  ).state("app.page.profile",
    url: "/profile"
    templateUrl: "tpl/page_profile.html"
  ).state("app.page.post",
    url: "/post"
    templateUrl: "tpl/page_post.html"
  ).state("app.page.search",
    url: "/search"
    templateUrl: "tpl/page_search.html"
  ).state("app.page.invoice",
    url: "/invoice"
    templateUrl: "tpl/page_invoice.html"
  ).state("app.docs",
    url: "/docs"
    templateUrl: "tpl/docs.html"
  ).state("lockme",
    url: "/lockme"
    templateUrl: "tpl/page_lockme.html"
  ).state("access",
    url: "/access"
    template: "<div ui-view class=\"fade-in-right-big smooth\"></div>"
  ).state("access.signin",
    url: "/signin"
    templateUrl: "tpl/page_signin.html"
  ).state("access.signup",
    url: "/signup"
    templateUrl: "tpl/page_signup.html"
  ).state("access.forgotpwd",
    url: "/forgotpwd"
    templateUrl: "tpl/page_forgotpwd.html"
  ).state("access.404",
    url: "/404"
    templateUrl: "tpl/page_404.html"
  ).state("app.calendar",
    url: "/calendar"
    templateUrl: "tpl/app_calendar.html"
    resolve:
      deps: [
        "uiLoad"
        (uiLoad) ->
          return uiLoad.load([
            "js/jquery/fullcalendar/fullcalendar.css"
            "js/jquery/jquery-ui-1.10.3.custom.min.js"
            "js/jquery/fullcalendar/fullcalendar.min.js"
            "js/app/calendar/ui-calendar.js"
            "js/app/calendar/calendar.js"
          ])
      ]
  ).state("app.mail",
    abstract: true
    url: "/mail"
    templateUrl: "tpl/mail.html"
    resolve:
      deps: [
        "uiLoad"
        (uiLoad) ->
          return uiLoad.load([
            "js/app/mail/mail.js"
            "js/app/mail/mail-service.js"
            "js/libs/moment.min.js"
          ])
      ]
  ).state("app.mail.list",
    url: "/inbox/{fold}"
    templateUrl: "tpl/mail.list.html"
  ).state("app.mail.detail",
    url: "/{mailId:[0-9]{1,4}}"
    templateUrl: "tpl/mail.detail.html"
  ).state "app.mail.compose",
    url: "/compose"
    templateUrl: "tpl/mail.new.html"

$locationProvider.html5Mode true
$httpProvider.interceptors.push 'authInterceptor'

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

