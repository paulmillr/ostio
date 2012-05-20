CollectionView = require 'chaplin/views/collection_view'
Thread = require 'views/thread_view'
template = require 'views/templates/threads'

module.exports = class ThreadsView extends CollectionView
  template: template

  getView: (item) ->
    new Thread model: item
