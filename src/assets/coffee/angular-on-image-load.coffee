angular.module('angular.on.image.load').directive 'onImageLoad',
  ($timeout) ->
    restrict: 'A'
    link: (scope, ele, attrs) ->
      loadingClasses = attrs.onImageLoad
      emitLoaded = ->
        scope.$emit 'ngSrcImageLoaded', ele, loadingClasses
      init = (unbind)->
        if unbind
          ele.unbind 'load'
          ele.unbind 'error'
        if ele[0].tagName.toLowerCase() isnt 'img'
          emitLoaded()
        else
          $timeout ->
            unless ele[0].complete
              ele.bind 'load', ->
                emitLoaded()
                return
              ele.bind 'error', ->
                emitLoaded()
                return
            else
              emitLoaded()
          , 0

      if attrs.ngSrc
        attrs.$observe "ngSrc", ->
          init true
      else
        init false

      return