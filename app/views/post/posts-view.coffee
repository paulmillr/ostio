CollectionView = require 'views/base/collection-view'

module.exports = class PostsView extends CollectionView
  className: 'topic-posts'
  itemView: require 'views/post/post-view'
  listen:
    'post:new mediator': 'push'
  listSelector: '.posts'
  loadingSelector: '.collection-indicator'
  fallbackSelector: '.collection-fallback'
  template: require './templates/posts'

  push: (post) ->
    @collection.push post

  # Show spinner only for >1s queries.
  toggleLoadingIndicator: ->
    unless @collection.length is 0 and @collection.isSyncing()
      super
      return
    setTimeout (=> super), 1000
