FormView = require 'views/base/form-view'
template = require './templates/edit-post-form'

module.exports = class EditPostFormView extends FormView
  className: 'post post-create'
  events:
    'keyup .edit-post-body': 'changeText'
    'keydown .edit-post-body': 'changeText'
  saveEvent: 'post:edit'
  template: template

  resizeTextArea: ->
    @edit ?= @find('.edit-post-body')
    setTimeout =>
      height = "#{@edit.scrollHeight + 10}px"
      @edit.style.height = 0
      @edit.style.transition = '1s height'
      @edit.style.height = height
    , 0

  # Update model data by default, save on ⌘R..
  changeText: (event) ->
    if event.metaKey and event.keyCode is 13
      @submit()
    else
      @model.set(text: event.delegateTarget.value.trim())

  render: ->
    super
    @resizeTextArea()

  publishSave: (response) ->
    @publishEvent @saveEvent, @model if @saveEvent
