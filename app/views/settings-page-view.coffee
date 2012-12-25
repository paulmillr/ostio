PageView = require 'views/base/page-view'
template = require './templates/settings-page'

module.exports = class SettingsPageView extends PageView
  autoRender: yes
  template: template

  initialize: ->
    super
    @delegate 'change', '#setting-email-notifications', @updateSetting

  updateSetting: (event) =>
    checked = $(event.currentTarget).attr('checked')
    @model.save enabled_email_notifications: checked
