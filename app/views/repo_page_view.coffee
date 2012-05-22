PageView = require 'views/page_view'
template = require 'views/templates/repo_page'
Collection = require 'models/collection'
Topic = require 'models/topic'
TopicsView = require 'views/topics_view'

module.exports = class RepoPageView extends PageView
  template: template

  renderSubviews: ->
    topics = new Collection null, model: Topic
    topics.url = @model.url('/topics/')
    @subview 'topics', new TopicsView
      collection: topics,
      container: @$('.repo-topic-list-container')
    topics.fetch()
