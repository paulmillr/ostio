mediator = require 'mediator'
Layout = require 'views/layout'

# The application object.
module.exports = class Application extends Chaplin.Application
  title: 'Ost.io'

  initLayout: (options = {}) ->
    @layout = new Layout options

  # Create additional mediator properties.
  initMediator: ->
    # Add additional application-specific properties and methods
    # e.g. mediator.prop = null
    mediator.createUser()
    # Seal the mediator.
    super

  start: ->
    mediator.user.fetch().then =>
      super
    , =>
      mediator.removeUser()
      super
