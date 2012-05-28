PageView = require 'views/page_view'
template = require 'views/templates/user_page'
Collection = require 'models/collection'
Repo = require 'models/repo'
ReposView = require 'views/repos_view'

module.exports = class UserPageView extends PageView
  template: template

  getNavigationData: ->
    gravatar_id: @model.get('gravatar_id'),
    user_login: @model.get('login')

  renderSubviews: ->
    repos = new Collection null, model: Repo
    repos.url = @model.url('/repos/')
    @subview 'repos', new ReposView
      collection: repos,
      container: @$('.user-repo-list-container')
    repos.fetch()

    syncRepos = new Collection null, model: Repo
    syncRepos.url = @model.url('/sync_repos/')
    syncRepos.fetch = (options) =>
      $.post syncRepos.url

    @delegate 'click', '.user-repo-sync-button', (event) =>
      $button = $(event.currentTarget)
      return if $button.attr('disabled')
      $button.attr('disabled', 'disabled')
      syncRepos.fetch()
        .success =>
          repos.fetch()
            .success =>
              $button.removeAttr('disabled')
