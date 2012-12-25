Controller = require 'controllers/base/controller'
mediator = require 'mediator'
SettingsPageView = require 'views/settings-page-view'

module.exports = class SettingsController extends Controller
  _show: =>
    model = mediator.user
    @view = new SettingsPageView {model}

  show: ->
    if mediator.user?
      @_show()
    else
      @subscribeEvent 'login', @_show
