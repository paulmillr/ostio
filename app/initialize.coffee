Application = require 'application'
routes = require 'routes'

Backbone.Deferred = -> new window.Davy
Backbone.resolveDeferred = (deferred, isResolved, args) ->
  deferred[if isResolved then 'fulfill' else 'reject'].apply deferred, args

# Initialize the application on DOM ready event.
document.addEventListener 'DOMContentLoaded', ->
  new Application {
    title: 'Ost.io',
    controllerSuffix: '-controller',
    routes
  }
, false
