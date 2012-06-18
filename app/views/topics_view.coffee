CollectionView = require 'views/base/collection_view'
Topic = require 'views/topic_view'

module.exports = class TopicsView extends CollectionView
  itemView: Topic
