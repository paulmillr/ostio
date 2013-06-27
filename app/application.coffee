Layout = require 'views/layout'

# The application object.
module.exports = class Application extends Chaplin.Application

# The application object.
module.exports = class Application extends Chaplin.Application
  title: 'Ost.io'

  initLayout: (options = {}) ->
    options.title ?= @title
    @layout = new Layout options

  # Create additional mediator properties.
  initMediator: ->
    # Add additional application-specific properties and methods
    # e.g. Chaplin.mediator.prop = null
    Chaplin.mediator.user = null
    # Seal the mediator.
    super
