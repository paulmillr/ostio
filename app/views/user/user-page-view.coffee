PageView = require 'views/base/page-view'
template = require './templates/user-page'

module.exports = class UserPageView extends PageView
  regions:
    'repos': '.user-repo-list-container'
    'sync-repos': '.user-repo-sync-container'
    'relations': '.user-relations'
  template: template

  getNavigationData: ->
    avatar_url: @model.get('avatar_url')
    user_login: @model.get('login')
