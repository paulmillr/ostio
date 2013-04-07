PageView = require 'views/base/page-view'
template = require './templates/settings-page'

module.exports = class SettingsPageView extends PageView
  autoRender: yes
  events:
    'change #setting-email-notifications': 'updateSetting'
  template: template

  updateSetting: (event) =>
    checked = $(event.currentTarget).prop('checked')
    @model.save enabled_email_notifications: checked
