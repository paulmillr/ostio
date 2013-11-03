FormView = require 'views/base/form-view'

module.exports = class NewPostFormView extends FormView
  className: 'post post-create'
  events:
    'keyup .new-post-body': 'changeText'
    'keydown .new-post-body': 'changeText'
  saveEvent: 'post:new'
  template: require './templates/new-post-form'

  # Update model data by default, save on ⌘R.
  changeText: (event) ->
    text = event.delegateTarget.value.trim()
    if event.metaKey and event.keyCode is 13
      @submit()
    else
      @model.set {text}
