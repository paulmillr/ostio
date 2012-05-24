PageView = require 'views/page_view'
template = require 'views/templates/repo_page'
Collection = require 'models/collection'
Topic = require 'models/topic'
NewTopicFormView = require 'views/new_topic_form_view'
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
    @subscribeEvent 'new:topic', (topic) =>
      topics.unshift topic

    createNewTopic = =>
      newTopic = new Topic({repo: @model})
      newTopicView = new NewTopicFormView
        model: newTopic,
        container: @$('.new-topic-form-container')
      newTopicView.on 'dispose', =>
        setTimeout createNewTopic, 0
      @subview 'newTopicForm', newTopicView
    createNewTopic()
