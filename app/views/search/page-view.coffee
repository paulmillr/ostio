PageView = require 'views/base/page-view'

module.exports = class SearchPageView extends PageView
  autoRender: true
  events:
    'keyup .search-input': 'search'
  template: require './templates/page'
  regions:
    posts: '.post-list-container'

  search: (event) ->
    query = event.target.value
    unless query
      @find('.post-list-container').classList.add('hidden')
      return
    if event.which is 13
      @find('.query-value').textContent = query
      {collection} = @subview('posts')
      collection.reset()
      collection.fetch(data: {query})
      @find('.post-list-container').classList.remove('hidden')

  render: ->
    super
    @find('.post-list-container').classList.add('hidden')
