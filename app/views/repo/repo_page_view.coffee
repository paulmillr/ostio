Collection = require 'models/base/collection'
NewTopicFormView = require 'views/topic/new_topic_form_view'
PageView = require 'views/base/page_view'
template = require 'views/templates/repo_page'
Topic = require 'models/topic'
TopicsView = require 'views/topic/topics_view'

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

    createNewTopic = =>
      newTopic = new Topic({repo: @model})
      newTopicView = new NewTopicFormView
        model: newTopic,
        container: @$('.new-topic-form-container')
      newTopicView.on 'dispose', =>
        setTimeout createNewTopic, 0
      @subview 'newTopicForm', newTopicView
    createNewTopic()

  dispose: ->
    return if @disposed
    @topics.dispose()
    delete @topics
    super
