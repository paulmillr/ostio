PageView = require 'views/base/page_view'
template = require 'views/templates/settings_page'

module.exports = class SettingsPageView extends PageView
  template: template
  autoRender: yes

  initialize: ->
    super
    @delegate 'change', '#setting-email-notifications', @updateSetting

  updateSetting: (event) =>
    checked = $(event.currentTarget).attr('checked')
    console.log 'Checked', checked
    @model.save enabled_email_notifications: checked
