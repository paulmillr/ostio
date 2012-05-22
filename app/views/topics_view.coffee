CollectionView = require 'chaplin/views/collection_view'
Topic = require 'views/topic_view'

module.exports = class TopicsView extends CollectionView
  getView: (item) ->
    new Topic model: item
