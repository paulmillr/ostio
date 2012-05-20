CollectionView = require 'chaplin/views/collection_view'
Post = require 'views/post_view'
template = require 'views/templates/posts'

module.exports = class PostsView extends CollectionView
  template: template

  getView: (item) ->
    new Post model: item
