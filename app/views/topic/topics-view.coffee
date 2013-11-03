CollectionView = require 'views/base/collection-view'
Topic = require 'views/topic/topic-view'

module.exports = class TopicsView extends CollectionView
  itemView: Topic
  listen:
    'topic:new mediator': 'push'

  push: (item) ->
    @collection.unshift item
