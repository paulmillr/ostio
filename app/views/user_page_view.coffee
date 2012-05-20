PageView = require 'views/page_view'
template = require 'views/templates/user_page'
Collection = require 'models/collection'
Repo = require 'models/repo'
ReposView = require 'views/repos_view'

module.exports = class UserPageView extends PageView
  template: template

  renderSubviews: ->
    repos = new Collection null, model: Repo
    repos.url = @model.url() + '/repos/'
    @subview 'repos', new ReposView
      collection: repos,
      container: @$('.user-repo-list-container')
    repos.fetch()
