NewTopicFormView = require 'views/topic/new-topic-form-view'
PageView = require 'views/base/page-view'
template = require './templates/repo-page'
Topic = require 'models/topic'

module.exports = class RepoPageView extends PageView
  regions:
    'new-topic': '.new-topic-form-container'
    'topics': '.repo-topic-list-container'
  template: template

  getNavigationData: ->
    gravatar_id: @model.get('user').get('gravatar_id')
    user_login: @model.get('user').get('login')
    repo_name: @model.get('name')

  render: ->
    super
    @createNewTopic()

  createNewTopic: ->
    @topic?.dispose()
    @topic = new Topic repo: @model
    topicView = new NewTopicFormView model: @topic, region: 'new-topic'
    @listenTo topicView, 'dispose', => setTimeout @createNewTopic.bind(this), 0
    @subview 'newTopicForm', topicView

  dispose: ->
    return if @disposed
    @topic?.dispose()
    super
