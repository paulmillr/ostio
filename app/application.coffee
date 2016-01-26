Chaplin = require 'chaplin'
mediator = require 'mediator'
Layout = require 'views/layout'

# The application object.
module.exports = class Application extends Chaplin.Application
  title: 'Ost.io'

  initLayout: (options = {}) ->
    options.title ?= @title
    @layout = new Layout options

  # Create additional mediator properties.
  initMediator: ->
    # Add additional application-specific properties and methods
    # e.g. mediator.prop = null
    mediator.createUser()
    # Seal the mediator.
    super

  # Start app after initial user request.
  start: ->
    mediator.user.fetch().then =>
      super
    , =>
      # Logout if there is no info..
      mediator.removeUser()
      super
