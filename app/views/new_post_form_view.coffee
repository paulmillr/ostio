FormView = require 'views/form_view'
template = require 'views/templates/new_post_form'

module.exports = class NewPostFormView extends FormView
  template: template
  className: 'topic-post topic-post-create'
  tagName: 'article'
  saveEvent: 'post:new'

  initialize: ->
    super
    @subscribeEvent 'loginStatus', @render
    @pass 'text', '.topic-new-post-body'
    @delegate 'keyup keydown', '.topic-new-post-body', @changeText

  # Update model data by default, save on ⌘R.
  changeText: (event) =>
    if event.metaKey and event.keyCode is 13
      @save()
    else
      @model.set(text: $(event.currentTarget).val())
