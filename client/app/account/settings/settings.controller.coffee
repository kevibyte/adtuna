'use strict'
# TODO - Seperate this

angular.module 'adtunaApp'
.controller 'SettingsCtrl', ($scope, User, Auth) ->
  $scope.errors = {}
  $scope.changePassword = (form) ->
    $scope.submitted = true
    if form.$valid
      Auth.changePassword $scope.user.oldPassword, $scope.user.newPassword
      .then ->
        $scope.message = 'Password successfully changed.'
      .catch ->
        form.password.$setValidity 'mongoose', false
        $scope.errors.other = 'Incorrect password'
        $scope.message = ''
angular.module('app.controllers', [])
.controller "FlotChartDemoCtrl", ($scope) ->
  $scope.d = [ [1,6.5],[2,6.5],[3,7],[4,8],[5,7.5],[6,7],[7,6.8],[8,7],[9,7.2],[10,7],[11,6.8],[12,7] ];
  $scope.d0_1 = [ [0,7],[1,6.5],[2,12.5],[3,7],[4,9],[5,6],[6,11],[7,6.5],[8,8],[9,7] ];
  $scope.d0_2 = [ [0,4],[1,4.5],[2,7],[3,4.5],[4,3],[5,3.5],[6,6],[7,3],[8,4],[9,3] ];
  $scope.d1_1 = [ [10, 120], [20, 70], [30, 70], [40, 60] ];
  $scope.d1_2 = [ [10, 50],  [20, 60], [30, 90],  [40, 35] ];
  $scope.d1_3 = [ [10, 80],  [20, 40], [30, 30],  [40, 20] ];
  $scope.d2 = [];
  $scope.d3 = [ 
    { label: "iPhone5S", data: 40 }, 
    { label: "iPad Mini", data: 10 },
    { label: "iPad Mini Retina", data: 20 },
    { label: "iPhone4S", data: 12 },
    { label: "iPad Air", data: 18 }
  ];
  $scope.getRandomData = ->
    data = []
    totalPoints = 150
    data = data.slice(1)  if data.length > 0
    while data.length < totalPoints
      prev = (if data.length > 0 then data[data.length - 1] else 50)
      y = prev + Math.random() * 10 - 5
      if y < 0
        y = 0
      else y = 100  if y > 100
      data.push y
    # Zip the generated y values with the x values
    res = []
    i = 0
    while i < data.length
      res.push [
        i
        data[i]
      ]
      ++i
    res
  $scope.d4 = $scope.getRandomData()
angular.module("app.directives", ["ui.load"])
.directive 'uiButterbar', ->
  restrict: 'AC'
  template: "<span class=\"bar\"></span>"
  link: (scope, el, attrs) ->
    console.log 'buttter init!!'
    el.addClass "butterbar hide"
    scope.$on "$stateChangeStart", (event) ->
      console.log 'buttter start!!'
      el.removeClass("hide").addClass "active"
    scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState) ->
      console.log 'buttter success!!'
      event.targetScope.$watch "$viewContentLoaded", ->
        el.addClass("hide").removeClass "active"
.directive 'uiShift', ($timeout) ->
  restrict: "A"
  replace: true
  link: (scope, el, attr) ->
    sm = ->
      $timeout ->
        method = attr.uiShift
        target = attr.target
        _el.hasClass("in") or _el[method](target).addClass("in")
    md = ->
      parent and parent["prepend"](el)
      not parent and _el["insertAfter"](prev)
      _el.removeClass "in"
    _el = $(el)
    _window = $(window)
    prev = _el.prev()
    parent = undefined
    width = _window.width()
    not prev.length and (parent = _el.parent())
    (width < 768 and sm()) or md()
    _window.resize ->
      if width isnt _window.width()
        $timeout ->
          (_window.width() < 768 and sm()) or md()
          width = _window.width()
.directive "uiToggleClass", ($timeout, $document) ->
  restrict: "AC"
  replace: true
  link: (scope, el, attr) ->
    el.on "click", (e) ->
      magic = (_class, target) ->
        patt = new RegExp("\\s" + _class.replace(/\*/g, "[A-Za-z0-9-_]+").split(" ").join("\\s|\\s") + "\\s", "g")
        cn = " " + $(target)[0].className + " "
        cn = cn.replace(patt, " ")  while patt.test(cn)
        $(target)[0].className = $.trim(cn)
      e.preventDefault()
      classes = attr.uiToggleClass.split(",")
      targets = (attr.target and attr.target.split(",")) or Array(el)
      key = 0
      angular.forEach classes, (_class) ->
        target = targets[(targets.length and key)]
        (_class.indexOf("*") isnt -1) and magic(_class, target)
        $(target).toggleClass _class
        key++
      $(el).toggleClass "active"
.directive "uiNav", ($timeout) ->
  restrict: "AC"
  replace: true
  link: (scope, el, attr) ->
    _window = $(window)
    _mb = 768
    $(el).on "click", "a", (e) ->
      _this = $(this)
      _this.parent().siblings(".active").toggleClass "active"
      _this.parent().toggleClass "active"
      _this.next().is("ul") and e.preventDefault()
      _this.next().is("ul") or ((_window.width() < _mb) and $(".app-aside").toggleClass("show"))
    wrap = $(".app-aside")
    next = undefined
    $(el).on "mouseenter", "a", (e) ->
      return  if not $(".app-aside-fixed.app-aside-folded").length or (_window.width() < _mb)
      _this = $(this)
      next and next.trigger("mouseleave.nav")
      if _this.next().is("ul")
        next = _this.next()
      else
        return
      next.appendTo(wrap).css "top", _this.offset().top - _this.height()
      next.on "mouseleave.nav", (e) ->
        next.appendTo _this.parent()
        next.off "mouseleave.nav"
        _this.parent().removeClass "active"
      _this.parent().addClass "active"
    wrap.on "mouseleave", (e) ->
      next and next.trigger("mouseleave.nav")
.directive "uiScroll", ($location, $anchorScroll) ->
  restrict: "AC"
  replace: true
  link: (scope, el, attr) ->
    el.on "click", (e) ->
      $location.hash attr.uiScroll
      $anchorScroll()
.directive "uiFullscreen", (uiLoad) ->
  restrict: "AC"
  template: "<i class=\"fa fa-expand fa-fw text\"></i><i class=\"fa fa-compress fa-fw text-active\"></i>"
  link: (scope, el, attr) ->
    el.addClass "hide"
    uiLoad.load("js/libs/screenfull.min.js").then ->
      el.removeClass "hide"  if screenfull.enabled
      el.on "click", ->
        target = undefined
        attr.target and (target = $(attr.target)[0])
        el.toggleClass "active"
        screenfull.toggle target
