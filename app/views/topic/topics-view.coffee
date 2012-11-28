CollectionView = require 'views/base/collection-view'
Topic = require 'views/topic/topic-view'

module.exports = class TopicsView extends CollectionView
  itemView: Topic
