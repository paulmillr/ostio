Collection = require 'models/base/collection'
NewTopicFormView = require 'views/topic/new-topic-form-view'
PageView = require 'views/base/page-view'
template = require './templates/repo-page'
Topic = require 'models/topic'
TopicsView = require 'views/topic/topics-view'

module.exports = class RepoPageView extends PageView
  template: template

  getNavigationData: ->
    gravatar_id: @model.get('user').get('gravatar_id')
    user_login: @model.get('user').get('login')
    repo_name: @model.get('name')

  renderSubviews: ->
    @topics = new Collection null, model: Topic
    @topics.url = @model.url('/topics/')
    @subview 'topics', new TopicsView
      collection: @topics,
      container: @$('.repo-topic-list-container')
    @topics.fetch()
    @subscribeEvent 'topic:new', (topic) =>
      @topics.unshift topic
    @createNewTopic()

  createNewTopic: =>
    topic = new Topic repo: @model
    topicView = new NewTopicFormView
      model: topic,
      container: @$('.new-topic-form-container')
    topicView.on 'dispose', =>
      setTimeout @createNewTopic, 0
    @subview 'newTopicForm', topicView

  dispose: ->
    return if @disposed
    @topics.dispose()
    delete @topics
    super
