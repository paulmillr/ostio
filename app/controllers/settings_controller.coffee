Controller = require 'controllers/base/controller'
mediator = require 'mediator'
SettingsPageView = require 'views/settings_page_view'

module.exports = class SettingsController extends Controller
  historyURL: 'settings'
  title: 'Settings'

  _show: =>
    model = mediator.user
    @view = new SettingsPageView {model}

  show: ->
    if mediator.user?
      @_show()
    else
      @subscribeEvent 'login', @_show
