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
    @$edit ?= @$('.edit-post-body')
    setTimeout =>
      height = "#{@$edit.prop('scrollHeight') + 10}px"
      @$edit.animate {height}, 250
    , 0

  # Update model data by default, save on ⌘R..
  changeText: (event) =>
    if event.metaKey and event.keyCode is 13
      @$el.trigger('submit')
    else
      @model.set(text: $(event.currentTarget).val())

  render: ->
    super
    @resizeTextArea()

  publishSave: (response) ->
    @publishEvent @saveEvent, @model if @saveEvent
