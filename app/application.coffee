mediator = require 'mediator'
ChaplinApplication = require 'chaplin/application'
SessionController = require 'controllers/session_controller'
HeaderController = require 'controllers/header_controller'
NavigationController = require 'controllers/navigation_controller'
routes = require 'routes'

# The application bootstrapper.
module.exports = class Application extends ChaplinApplication
  title: 'Ostio'

  initialize: ->
    ###console.debug 'ExampleApplication#initialize'###

    super # This creates the AppController and AppView

    # Instantiate common controllers
    # ------------------------------

    new SessionController()
    new HeaderController()
    new NavigationController()

    # Initialize the router
    # ---------------------

    # This creates the mediator.router property and
    # starts the Backbone history.
    @initRouter routes, pushState: yes

    # Finish
    # ------

    # Freeze the application instance to prevent further changes
    Object.freeze? this
