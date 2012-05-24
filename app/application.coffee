mediator = require 'mediator'
ChaplinApplication = require 'chaplin/application'
SessionController = require 'controllers/session_controller'
HeaderController = require 'controllers/header_controller'
SidebarController = require 'controllers/sidebar_controller'
routes = require 'routes'

# The application bootstrapper.
module.exports = class Application extends ChaplinApplication
  title: 'Example brunch application'

  initialize: ->
    ###console.debug 'ExampleApplication#initialize'###

    super # This creates the AppController and AppView

    # Instantiate common controllers
    # ------------------------------

    new SessionController()
    new HeaderController()
    new SidebarController()

    # Initialize the router
    # ---------------------

    # This creates the mediator.router property and
    # starts the Backbone history.
    @initRouter routes, pushState: yes

    # Finish
    # ------

    # Freeze the application instance to prevent further changes
    Object.freeze? this
