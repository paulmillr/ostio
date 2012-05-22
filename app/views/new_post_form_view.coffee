mediator = require 'mediator'
View = require 'views/view'
template = require 'views/templates/new_post_form'

module.exports = class NewPostFormView extends View
  template: template
  autoRender: yes

  initialize: ->
    super
    @pass 'text', '.topic-new-post-body'
    cache = null
    @delegate 'keyup keydown', '.topic-new-post-body', (event) =>
      cache ?= @$('.topic-new-post-body')
      @model.set(text: cache.val())

    @delegate 'click', '.topic-new-post-create-button', (event) =>
      @model.save().success (response) =>
        mediator.publish 'new:post', response
        @dispose()
