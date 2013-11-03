PageView = require 'views/base/page-view'
template = require './templates/settings-page'

module.exports = class SettingsPageView extends PageView
  autoRender: true
  events:
    'change #setting-email-notifications': 'updateSetting'
  listen:
    'loginStatus mediator': 'redirectIfLoggedOut'
  template: template

  updateSetting: (event) ->
    @model.save enabled_email_notifications: event.delegateTarget.checked

  redirectIfLoggedOut: (isLoggedIn) ->
    Chaplin.helpers.redirectTo 'home#show' unless isLoggedIn
