Collection = require 'models/base/collection'
OrganizationOwnersView = require 'views/user/organization-owners-view'
PageView = require 'views/base/page-view'
Repo = require 'models/repo'
ReposView = require 'views/repo/repos-view'
template = require './templates/user-page'
User = require 'models/user'
UserOrganizationsView = require 'views/user/user-organizations-view'
UsersView = require 'views/user/users-view'
UserRepoSyncView = require 'views/user/user-repo-sync-view'

module.exports = class UserPageView extends PageView
  template: template

  getNavigationData: ->
    gravatar_id: @model.get('gravatar_id'),
    user_login: @model.get('login')

  renderSubviews: ->
    # Main repositories collection.
    @repos = new Collection null, model: Repo
    @repos.url = @model.url('/repos/')
    @subview 'repos', new ReposView
      collection: @repos,
      container: @$('.user-repo-list-container')
    @repos.fetch()

    @organizations = @model.get('organizations')
    @owners = @model.get('owners')

    # If current page is user’s page, create organizations subview.
    # Otherwise, create organization managers subview.
    if @model.get('type') is 'User' and @organizations.length > 0
      @subview 'organizations', new UserOrganizationsView
        collection: @organizations,
        container: @$('.user-organization-list-container')
    else if @owners.length > 0
      @subview 'owners', new OrganizationOwnersView
        collection: @owners,
        container: @$('.user-owner-list-container')

    # “Sync repos” button.
    @repoSync = new Collection null, model: Repo
    @repoSync.url = @model.url('/sync_repos/')
    @repoSync.fetch = (options) =>
      $.post @repoSync.url
    repoSyncView = new UserRepoSyncView
      collection: @repoSync,
      container: @$('.user-repo-sync-container'),
      login: @model.get('login')
    @subview 'repoSync', repoSyncView
    repoSyncView.on 'sync', =>
      @repos.fetch()

  dispose: ->
    return if @disposed
    ['repos', 'organizations', 'owners', 'repoSync'].forEach (attr) =>
      this[attr].dispose()
      delete this[attr]
    super
