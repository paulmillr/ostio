mediator = require 'mediator'
View = require 'views/view'
template = require 'views/templates/new_topic_form'
Post = require 'models/post'

module.exports = class NewTopicFormView extends View
  template: template
  autoRender: yes
  className: 'new-topic-form'

  initialize: ->
    super

    @post = new Post({topic: @model})
    @delegate 'click', '.new-topic-form-toggle-fields-button', (event) =>
      $(event.currentTarget).toggleClass('hover')
      @$('.new-topic-form-fields').toggleClass('hidden')
    
    @delegate 'keyup keydown', '.new-topic-form-title', (event) =>
      @model.set(title: $(event.currentTarget).val())

    @delegate 'keyup keydown', '.new-topic-form-text', (event) =>
      @post.set(text: $(event.currentTarget).val())

    @delegate 'click', '.new-topic-form-submit-button', (event) =>
      @model.save().success (response) =>
        @post.save()
          .success (postResponse) =>
            mediator.publish 'new:topic', response
            @trigger 'dispose'
            @dispose()
          .error (error) =>
            console.error error
            @model.destroy()
