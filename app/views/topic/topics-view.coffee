CollectionView = require 'views/base/collection-view'
Topic = require 'views/topic/topic-view'

module.exports = class TopicsView extends CollectionView
  itemView: Topic
  listen:
    'topic:new mediator': 'push'

  push: (item) ->
    @collection.unshift item

  filterer: (model) ->
    matchesFilterer = (attr) =>
      index = attr.toLowerCase().indexOf(@filteredTitle)
      index isnt -1

    if @filteredTitle
      matchesFilterer(model.get('title')) or matchesFilterer(model.get('user').login)
    else
      true

  filterCallback: (view, included) ->
    # console.log view.el
    method = [if included then 'remove' else 'add']
    classes = view.el.classList
    classes[method] 'filtering'
    classes[method] 'filtered'
    classes.remove 'hidden' if included


  reFilter: (value) ->
    @filteredTitle = value.toLowerCase()
    @filter()

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
