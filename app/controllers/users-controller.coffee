Controller = require 'controllers/base/controller'
User = require 'models/user'
UserPageView = require 'views/user/user-page-view'

Collection = require 'models/base/collection'
OrganizationOwnersView = require 'views/user/organization-owners-view'
Repo = require 'models/repo'
ReposView = require 'views/repo/repos-view'
User = require 'models/user'
UserOrganizationsView = require 'views/user/user-organizations-view'
UsersView = require 'views/user/users-view'
UserRepoSyncView = require 'views/user/user-repo-sync-view'

module.exports = class UsersController extends Controller
  _showRepos: ->
    # Main repositories collection.
    @repos = new Collection null, model: Repo
    @repos.url = @model.url('/repos/')
    @reposView = new ReposView collection: @repos, region: 'repos'
    @repos.fetch()

  _showOrganizations: ->
    @organizations = @model.get('organizations')
    @owners = @model.get('owners')

    # If current page is user’s page, create organizations subview.
    # Otherwise, create organization managers subview.
    if @model.get('type') is 'User' and @organizations.length > 0
      @organizationsView = new UserOrganizationsView
        collection: @organizations, region: 'relations'
    else if @owners.length > 0
      @ownersView = new OrganizationOwnersView
        collection: @owners, region: 'relations'

  _initSyncRepos: ->
    # “Sync repos” button.
    @repoSync = new Collection null, model: Repo
    @repoSync.url = @model.url('/sync_repos')
    @repoSync.fetch = (options) =>
      Backbone.utils.ajax
        url: @repoSync.url,
        type: 'POST'
    @repoSyncView = new UserRepoSyncView
      collection: @repoSync,
      region: 'sync-repos'
      login: @model.get('login')
    @repoSyncView.on 'sync', => @repos.fetch()

  show: (params) ->
    @model = new User {login: params.login}
    @view = new UserPageView {@model}
    @model.fetch().then =>
      @view.render()
      @_showRepos()
      @_showOrganizations()
      @_initSyncRepos()
