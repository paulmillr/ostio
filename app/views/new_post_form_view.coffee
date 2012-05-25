mediator = require 'mediator'
View = require 'views/view'
template = require 'views/templates/new_post_form'

module.exports = class NewPostFormView extends View
  template: template
  autoRender: yes
  className: 'topic-post topic-post-create'
  tagName: 'article'

  initialize: ->
    super
    @pass 'text', '.topic-new-post-body'

    # Update model data by default, save on ⌘R.
    @delegate 'keyup keydown', '.topic-new-post-body', (event) =>
      if event.metaKey and event.keyCode is 13
        @save()
      else
        @model.set(text: $(event.currentTarget).val())

    # Save on button submit.
    @delegate 'click', '.topic-new-post-create-button', @save

  save: (event) =>
    @model.save().success (response) =>
      mediator.publish 'new:post', response
      @trigger 'dispose'
      @dispose()
