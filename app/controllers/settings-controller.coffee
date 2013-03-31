Controller = require 'controllers/base/controller'
Chaplin = require 'chaplin'
SettingsPageView = require 'views/settings-page-view'

module.exports = class SettingsController extends Controller
  _show: =>
    model = Chaplin.mediator.user
    @view = new SettingsPageView {model}

  show: ->
    if Chaplin.mediator.user?
      @_show()
    else
      @subscribeEvent 'login', @_show
