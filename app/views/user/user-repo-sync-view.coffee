View = require 'views/base/view'
template = require './templates/user-repo-sync'

module.exports = class UserRepoSyncView extends View
  autoRender: true
  className: 'user-repo-sync'
  events:
    'click .user-repo-sync-button': 'sync'
  listen:
    'loginStatus mediator': 'render'
  template: template

  initialize: (args) ->
    super
    @login = args.login

  getTemplateData: ->
    obj = super
    obj.login = @login
    obj

  sync: (event) ->
    button = event.delegateTarget
    return if button.disabled
    button.setAttribute 'disabled', 'disabled'
    @collection.fetch().then =>
      button.removeAttribute 'button'
      @trigger 'sync'
