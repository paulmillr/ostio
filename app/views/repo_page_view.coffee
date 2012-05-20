PageView = require 'views/page_view'
template = require 'views/templates/repo_page'
Collection = require 'models/collection'
Thread = require 'models/thread'
ThreadsView = require 'views/threads_view'

module.exports = class RepoPageView extends PageView
  template: template

  renderSubviews: ->
    threads = new Collection null, model: Thread
    threads.url = @model.url() + '/threads/'
    @subview 'threads', new ThreadsView
      collection: threads,
      container: @$('.repo-thread-list-container')
    threads.fetch()
