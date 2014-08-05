'use strict'

angular.module 'adtunaApp'
.controller 'SettingsCtrl', ($scope, User, Auth) ->
    isTouchDevice = !!("ontouchstart" of window)
    isIE = !!navigator.userAgent.match(/MSIE/i)
    not isTouchDevice and $("html").addClass("no-touch")
    isIE and $("html").addClass("ie")
    $scope.app =
      name: "AdTuna"
      version: "1.0.0"
      color:
        primary: "#7266ba"
        info: "#23b7e5"
        success: "#27c24c"
        warning: "#fad733"
        danger: "#f05050"
        light: "#e8eff0"
        dark: "#3a3f51"
        black: "#1c2b36"

      settings:
        navbarHeaderColor: "bg-primary"
        navbarCollapseColor: "bg-primary dk"
        asideColor: "bg-black"
        headerFixed: true
        asideFixed: false
        asideFolded: false
angular.module('app.controllers', [])
.controller "AccordionDemoCtrl", ($scope) ->
    $scope.oneAtATime = true
    $scope.groups = [
      {
        title: "Accordion group header - #1"
        content: "Dynamic group body - #1"
      }
      {
        title: "Accordion group header - #2"
        content: "Dynamic group body - #2"
      }
    ]
    $scope.items = [
      "Item 1"
      "Item 2"
      "Item 3"
    ]
    $scope.addItem = ->
      newItemNo = $scope.items.length + 1
      $scope.items.push "Item " + newItemNo
      return

    $scope.status =
      isFirstOpen: true
      isFirstDisabled: false
.controller "AlertDemoCtrl", ($scope) ->
    $scope.alerts = [
      {
        type: "success"
        msg: "Well done! You successfully read this important alert message."
      }
      {
        type: "info"
        msg: "Heads up! This alert needs your attention, but it is not super important."
      }
      {
        type: "warning"
        msg: "Warning! Best check yo self, you are not looking too good..."
      }
    ]
    $scope.addAlert = ->
      $scope.alerts.push
        type: "danger"
        msg: "Oh snap! Change a few things up and try submitting again."

      return

    $scope.closeAlert = (index) ->
      $scope.alerts.splice index, 1
      return
.controller "ButtonsDemoCtrl", ($scope) ->
    $scope.singleModel = 1
    $scope.radioModel = "Middle"
    $scope.checkModel =
      left: false
      middle: true
      right: false
.controller "CarouselDemoCtrl", ($scope) ->
    $scope.myInterval = 5000
    slides = $scope.slides = []
    $scope.addSlide = ->
      slides.push
        image: "img/c" + slides.length + ".jpg"
        text: [
          "Carousel text #0"
          "Carousel text #1"
          "Carousel text #2"
          "Carousel text #3"
        ][slides.length % 4]

      return

    i = 0

    while i < 4
      $scope.addSlide()
      i++
.controller "DropdownDemoCtrl", ($scope) ->
    $scope.items = [
      "The first choice!"
      "And another choice for you."
      "but wait! A third!"
    ]
    $scope.status = isopen: false
    $scope.toggled = (open) ->

    $scope.toggleDropdown = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.status.isopen = not $scope.status.isopen
      return
.controller "ModalDemoCtrl", ($scope, $modal, $log) ->
    $scope.items = [
      "item1"
      "item2"
      "item3"
    ]
    ModalInstanceCtrl = ($scope, $modalInstance, items) ->
      $scope.items = items
      $scope.selected = item: $scope.items[0]
      $scope.ok = ->
        $modalInstance.close $scope.selected.item
        return

      $scope.cancel = ->
        $modalInstance.dismiss "cancel"
        return

      return

    $scope.open = (size) ->
      modalInstance = $modal.open(
        templateUrl: "myModalContent.html"
        controller: ModalInstanceCtrl
        size: size
        resolve:
          items: ->
            $scope.items
      )
      modalInstance.result.then ((selectedItem) ->
        $scope.selected = selectedItem
        return
      ), ->
        $log.info "Modal dismissed at: " + new Date()
        return

      return
.controller "PaginationDemoCtrl", ($scope, $log) ->
    $scope.totalItems = 64
    $scope.currentPage = 4
    $scope.setPage = (pageNo) ->
      $scope.currentPage = pageNo
      return

    $scope.pageChanged = ->
      $log.info "Page changed to: " + $scope.currentPage
      return

    $scope.maxSize = 5
    $scope.bigTotalItems = 175
    $scope.bigCurrentPage = 1
.controller "PopoverDemoCtrl", ($scope) ->
    $scope.dynamicPopover = "Hello, World!"
    $scope.dynamicPopoverTitle = "Title"
.controller "ProgressDemoCtrl", ($scope) ->
    $scope.max = 200
    $scope.random = ->
      value = Math.floor((Math.random() * 100) + 1)
      type = undefined
      if value < 25
        type = "success"
      else if value < 50
        type = "info"
      else if value < 75
        type = "warning"
      else
        type = "danger"
      $scope.showWarning = (type is "danger" or type is "warning")
      $scope.dynamic = value
      $scope.type = type
      return

    $scope.random()
    $scope.randomStacked = ->
      $scope.stacked = []
      types = [
        "success"
        "info"
        "warning"
        "danger"
      ]
      i = 0
      n = Math.floor((Math.random() * 4) + 1)

      while i < n
        index = Math.floor((Math.random() * 4))
        $scope.stacked.push
          value: Math.floor((Math.random() * 30) + 1)
          type: types[index]

        i++
      return

    $scope.randomStacked()
.controller "TabsDemoCtrl", ($scope) ->
    $scope.tabs = [
      {
        title: "Dynamic Title 1"
        content: "Dynamic content 1"
      }
      {
        title: "Dynamic Title 2"
        content: "Dynamic content 2"
        disabled: true
      }
    ]
.controller "RatingDemoCtrl", ($scope) ->
    $scope.rate = 7
    $scope.max = 10
    $scope.isReadonly = false
    $scope.hoveringOver = (value) ->
      $scope.overStar = value
      $scope.percent = 100 * (value / $scope.max)
      return
.controller "TooltipDemoCtrl", ($scope) ->
    $scope.dynamicTooltip = "Hello, World!"
    $scope.dynamicTooltipText = "dynamic"
    $scope.htmlTooltip = "I've been made <b>bold</b>!"
.controller "TypeaheadDemoCtrl", ($scope, $http) ->
    $scope.selected = `undefined`
    $scope.states = [
      "Alabama"
      "Alaska"
      "Arizona"
      "Arkansas"
      "California"
      "Colorado"
      "Connecticut"
      "Delaware"
      "Florida"
      "Georgia"
      "Hawaii"
      "Idaho"
      "Illinois"
      "Indiana"
      "Iowa"
      "Kansas"
      "Kentucky"
      "Louisiana"
      "Maine"
      "Maryland"
      "Massachusetts"
      "Michigan"
      "Minnesota"
      "Mississippi"
      "Missouri"
      "Montana"
      "Nebraska"
      "Nevada"
      "New Hampshire"
      "New Jersey"
      "New Mexico"
      "New York"
      "North Dakota"
      "North Carolina"
      "Ohio"
      "Oklahoma"
      "Oregon"
      "Pennsylvania"
      "Rhode Island"
      "South Carolina"
      "South Dakota"
      "Tennessee"
      "Texas"
      "Utah"
      "Vermont"
      "Virginia"
      "Washington"
      "West Virginia"
      "Wisconsin"
      "Wyoming"
    ]
    $scope.getLocation = (val) ->
      $http.get("http://maps.googleapis.com/maps/api/geocode/json",
        params:
          address: val
          sensor: false
      ).then (res) ->
        addresses = []
        angular.forEach res.data.results, (item) ->
          addresses.push item.formatted_address
          return

        addresses

.controller "DatepickerDemoCtrl", ($scope) ->
    $scope.today = ->
      $scope.dt = new Date()
      return

    $scope.today()
    $scope.clear = ->
      $scope.dt = null
      return

    $scope.disabled = (date, mode) ->
      mode is "day" and (date.getDay() is 0 or date.getDay() is 6)

    $scope.toggleMin = ->
      $scope.minDate = (if $scope.minDate then null else new Date())
      return

    $scope.toggleMin()
    $scope.open = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened = true
      return

    $scope.dateOptions =
      formatYear: "yy"
      startingDay: 1
      class: "datepicker"

    $scope.initDate = new Date("2016-15-20")
    $scope.formats = [
      "dd-MMMM-yyyy"
      "yyyy/MM/dd"
      "dd.MM.yyyy"
      "shortDate"
    ]
    $scope.format = $scope.formats[0]
.controller "TimepickerDemoCtrl", ($scope) ->
    $scope.mytime = new Date()
    $scope.hstep = 1
    $scope.mstep = 15
    $scope.options =
      hstep: [
        1
        2
        3
      ]
      mstep: [
        1
        5
        10
        15
        25
        30
      ]

    $scope.ismeridian = true
    $scope.toggleMode = ->
      $scope.ismeridian = not $scope.ismeridian
      return

    $scope.update = ->
      d = new Date()
      d.setHours 14
      d.setMinutes 0
      $scope.mytime = d
      return

    $scope.changed = ->

    $scope.clear = ->
      $scope.mytime = null
      return
.controller "FormDemoCtrl", ($scope) ->
    $scope.notBlackListed = (value) ->
      blacklist = [
        "bad@domain.com"
        "verybad@domain.com"
      ]
      blacklist.indexOf(value) is -1

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
.controller "FlotChartDemoCtrl", [
  "$scope"
  ($scope) ->
    $scope.d = [
      [
        1
        6.5
      ]
      [
        2
        6.5
      ]
      [
        3
        7
      ]
      [
        4
        8
      ]
      [
        5
        7.5
      ]
      [
        6
        7
      ]
      [
        7
        6.8
      ]
      [
        8
        7
      ]
      [
        9
        7.2
      ]
      [
        10
        7
      ]
      [
        11
        6.8
      ]
      [
        12
        7
      ]
    ]
    $scope.d0_1 = [
      [
        0
        7
      ]
      [
        1
        6.5
      ]
      [
        2
        12.5
      ]
      [
        3
        7
      ]
      [
        4
        9
      ]
      [
        5
        6
      ]
      [
        6
        11
      ]
      [
        7
        6.5
      ]
      [
        8
        8
      ]
      [
        9
        7
      ]
    ]
    $scope.d0_2 = [
      [
        0
        4
      ]
      [
        1
        4.5
      ]
      [
        2
        7
      ]
      [
        3
        4.5
      ]
      [
        4
        3
      ]
      [
        5
        3.5
      ]
      [
        6
        6
      ]
      [
        7
        3
      ]
      [
        8
        4
      ]
      [
        9
        3
      ]
    ]
    $scope.d1_1 = [
      [
        10
        120
      ]
      [
        20
        70
      ]
      [
        30
        70
      ]
      [
        40
        60
      ]
    ]
    $scope.d1_2 = [
      [
        10
        50
      ]
      [
        20
        60
      ]
      [
        30
        90
      ]
      [
        40
        35
      ]
    ]
    $scope.d1_3 = [
      [
        10
        80
      ]
      [
        20
        40
      ]
      [
        30
        30
      ]
      [
        40
        20
      ]
    ]
    $scope.d2 = []
    i = 0

    while i < 20
      $scope.d2.push [
        i
        Math.sin(i)
      ]
      ++i
    $scope.d3 = [
      {
        label: "iPhone5S"
        data: 40
      }
      {
        label: "iPad Mini"
        data: 10
      }
      {
        label: "iPad Mini Retina"
        data: 20
      }
      {
        label: "iPhone4S"
        data: 12
      }
      {
        label: "iPad Air"
        data: 18
      }
    ]
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
]
