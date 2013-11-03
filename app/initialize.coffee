Application = require 'application'
routes = require 'routes'

# Set Deferred to Davy.js deferred.
Backbone.Deferred = ->
  p = new window.Davy
  promise: p, resolve: p.fulfill.bind(p), reject: p.reject.bind(p)

# Initialize the application on DOM ready event.
document.addEventListener 'DOMContentLoaded', ->
  new Application {
    title: 'Ost.io',
    controllerSuffix: '-controller',
    routes
  }
, false
