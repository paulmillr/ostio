CollectionView = require 'chaplin/views/collection_view'
Topic = require 'views/topic_view'
template = require 'views/templates/topics'

module.exports = class TopicsView extends CollectionView
  template: template

  getView: (item) ->
    new Topic model: item
