View = require 'views/view'
template = require 'views/templates/user_repo_sync'

module.exports = class UserRepoSyncView extends View
  template: template
  className: 'user-repo-sync'
  autoRender: yes

  initialize: (args) ->
    super
    @login = args.login
    @subscribeEvent 'loginStatus', @render
    @delegate 'click', '.user-repo-sync-button', @sync

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
