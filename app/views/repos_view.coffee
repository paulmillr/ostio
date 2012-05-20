CollectionView = require 'chaplin/views/collection_view'
Repo = require 'views/repo_view'
template = require 'views/templates/repos'

module.exports = class ReposView extends CollectionView
  template: template
  tagName: 'ul'
  className: 'user-repo-list'

  getView: (item) ->
    new Repo model: item
