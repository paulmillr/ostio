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
    @delegate 'keyup keydown', '.topic-new-post-body', (event) =>
      @model.set(text: $(event.currentTarget).val())

    @delegate 'click', '.topic-new-post-create-button', (event) =>
      @model.save().success (response) =>
        mediator.publish 'new:post', response
        @trigger 'dispose'
        @dispose()
