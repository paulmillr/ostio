View = require 'views/base/view'
template = require './templates/user-repo-sync'

module.exports = class UserRepoSyncView extends View
  autoRender: yes
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

  sync: (event) =>
    $button = $(event.currentTarget)
    return if $button.attr('disabled')
    $button.attr('disabled', 'disabled')
    @collection.fetch()
      .done =>
        $button.removeAttr('disabled')
        @trigger 'sync'
