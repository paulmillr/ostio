FormView = require 'views/base/form-view'
template = require 'views/templates/new-topic-form'
Post = require 'models/post'
SpinnerView = require 'views/spinner-view'

module.exports = class NewTopicFormView extends FormView
  className: 'new-topic-form'
  saveEvent: 'topic:new'
  template: template

  initialize: ->
    super
    @post = new Post topic: @model
    @delegate 'click', '.new-topic-form-toggle-fields-button', @toggleFields
    @delegate 'keyup keydown', '.new-topic-form-title', @changeTitle
    @delegate 'keyup keydown', '.new-topic-form-text', @changeText

  toggleFields: (event) =>
    $(event.currentTarget).toggleClass('active')
    @$('.new-topic-form-fields').toggleClass('visible')

  changeTitle: (event) =>
    return unless event.currentTarget.validity.valid
    if event.metaKey and event.keyCode is 13
      @$el.trigger('submit')
    else
      @model.set(title: $(event.currentTarget).val())

  changeText: (event) =>
    return unless event.currentTarget.validity.valid
    if event.metaKey and event.keyCode is 13
      @$el.trigger('submit')
    else
      @post.set(text: $(event.currentTarget).val())

  save: (event) =>
    spinner = new SpinnerView container: @$('.submit-form')
    @model.save()
      .done (response) =>
        @post.save()
          .done (postResponse) =>
            @$('.new-topic-form-toggle-fields-button').click()
            @setTimeout 'save', =>
              @publishSave response
              @trigger 'dispose'
              @dispose()
            , 300
          .fail (error) =>
            console.error 'NewTopicFormView#save', error
            @model.destroy()
          .always =>
            spinner.dispose()
      .fail =>
        spinner.dispose()

  dispose: ->
    return if @disposed
    @post.dispose()
    delete @post
    super
