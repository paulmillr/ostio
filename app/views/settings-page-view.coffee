PageView = require 'views/base/page-view'
utils = require 'lib/utils'
template = require './templates/settings-page'

module.exports = class SettingsPageView extends PageView
  autoRender: true
  events:
    'change #setting-email-notifications': 'updateSetting'
  listen:
    'loginStatus mediator': 'redirectIfLoggedOut'
  template: template

  updateSetting: (event) ->
    @model.save enabled_email_notifications: event.target.checked

  redirectIfLoggedOut: (isLoggedIn) ->
    utils.redirectTo 'home#show' unless isLoggedIn
