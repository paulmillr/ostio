FormView = require 'views/base/form-view'
template = require './templates/new-topic-form'
Post = require 'models/post'
SpinnerView = require 'views/spinner-view'

module.exports = class NewTopicFormView extends FormView
  className: 'new-topic-form'
  events:
    'click .new-topic-form-toggle-fields-button': 'toggleFields'
    'keyup .new-topic-form-title': 'changeTitle'
    'keydown .new-topic-form-title': 'changeTitle'
    'keyup .new-topic-form-text': 'changeText'
    'keydown .new-topic-form-text': 'changeText'
  saveEvent: 'topic:new'
  template: template

  initialize: ->
    super
    @post = new Post topic: @model

  toggleFields: (event) ->
    event.delegateTarget.classList.add 'active'
    @find('.new-topic-form-fields').classList.add 'visible'

  changeTitle: (event) ->
    return unless event.delegateTarget.validity.valid
    if event.metaKey and event.keyCode is 13
      @submit()
    else
      @model.set title: event.delegateTarget.value

  changeText: (event) ->
    return unless event.delegateTarget.validity.valid
    if event.metaKey and event.keyCode is 13
      @submit()
    else
      @post.set text: event.delegateTarget.value

  save: ->
    spinner = new SpinnerView container: @find('.submit-form')
    end = -> spinner.dispose()
    @model.save()
      .then (response) =>
        @post.save()
          .then (postResponse) =>
            @find('.new-topic-form-toggle-fields-button').click()
            @publishSave response
            @trigger 'dispose'
            @dispose()
            end()
          , (error) =>
            @model.destroy()
            end()
      , end

  dispose: ->
    return if @disposed
    @post.dispose()
    delete @post
    super
