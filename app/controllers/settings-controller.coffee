Controller = require 'controllers/base/controller'
SettingsPageView = require 'views/settings-page-view'
mediator = require 'mediator'

module.exports = class SettingsController extends Controller
  _show: =>
    @view = new SettingsPageView {model: mediator.user}

  show: ->
    if mediator.user?
      @_show()
    else
      @subscribeEvent 'login', @_show
