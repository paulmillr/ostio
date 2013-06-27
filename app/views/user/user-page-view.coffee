PageView = require 'views/base/page-view'
template = require './templates/user-page'

module.exports = class UserPageView extends PageView
  regions:
    '.user-repo-list-container': 'repos'
    '.user-repo-sync-container': 'sync-repos'
    '.user-relations': 'relations'
  template: template

  getNavigationData: ->
    gravatar_id: @model.get('gravatar_id'),
    user_login: @model.get('login')
