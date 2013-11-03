CollectionView = require 'views/base/collection-view'
Topic = require 'views/topic/topic-view'

module.exports = class TopicsView extends CollectionView
  itemView: Topic
  listen:
    'topic:new mediator': 'push'

  push: (item) ->
    @collection.unshift item

  # To test rendering performance of ~100 views:
  # 1. Edit `bower.json`, add
  #     `"exoskeleton": {"dependencies": {"jquery": "2"}}`
  # Do `bower install` then.
  # 2. Go to "brunch/brunch" repo assuming you're using production data,
  # then uncomment these lines in browser that supports `performance.now()`.
  # And watch browser console.

  # renderAllItems: ->
  #   now = performance.now()
  #   super
  #   console.log 'TopicsView#renderAllItems', performance.now() - now, 'ms'
