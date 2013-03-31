FormView = require 'views/base/form-view'
template = require './templates/new-post-form'

module.exports = class NewPostFormView extends FormView
  className: 'post post-create'
  events:
    'keyup .new-post-body': 'changeText'
    'keydown .new-post-body': 'changeText'
  saveEvent: 'post:new'
  template: template

  # Update model data by default, save on ⌘R.
  changeText: (event) =>
    text = $(event.currentTarget).val().trim()
    if event.metaKey and event.keyCode is 13
      @$el.trigger('submit')
    else
      @model.set {text}
