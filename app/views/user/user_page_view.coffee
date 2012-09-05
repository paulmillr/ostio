Collection = require 'models/base/collection'
OrganizationOwnersView = require 'views/user/organization_owners_view'
PageView = require 'views/base/page_view'
Repo = require 'models/repo'
ReposView = require 'views/repo/repos_view'
template = require 'views/templates/user_page'
User = require 'models/user'
UserOrganizationsView = require 'views/user/user_organizations_view'
UsersView = require 'views/user/users_view'

UserRepoSyncView = require 'views/user/user_repo_sync_view'

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

    organizations = @model.get('organizations')
    owners = @model.get('owners')
    if @model.get('type') is 'User' and organizations.length > 0
      @subview 'organizations', new UserOrganizationsView
        collection: organizations,
        container: @$('.user-organization-list-container')
    else if owners.length > 0
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
