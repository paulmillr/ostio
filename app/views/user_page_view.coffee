PageView = require 'views/page_view'
template = require 'views/templates/user_page'
Collection = require 'models/collection'
Repo = require 'models/repo'
User = require 'models/user'
ReposView = require 'views/repos_view'
UsersView = require 'views/users_view'
UserOrganizationsView = require 'views/user_organizations_view'
OrganizationOwnersView = require 'views/organization_owners_view'
UserRepoSyncView = require 'views/user_repo_sync_view'

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

    if @model.get('type') is 'User'
      organizations = new Collection @model.get('organizations'), model: User
      @subview 'organizations', new UserOrganizationsView
        collection: organizations,
        container: @$('.user-organization-list-container')
    else
      owners = new Collection @model.get('owners'), model: User
      @subview 'owners', new OrganizationOwnersView
        collection: owners,
        container: @$('.user-owner-list-container')

    repoSync = new Collection null, model: Repo
    repoSync.url = @model.url('/sync_repos/')
    repoSync.fetch = (options) =>
      $.post repoSync.url
    repoSyncView = new UserRepoSyncView
      collection: repoSync,
      container: @$('.user-repo-sync-container'),
      login: @model.get('login')
    @subview 'repoSync', repoSyncView
    repoSyncView.on 'sync', =>
      repos.fetch()
