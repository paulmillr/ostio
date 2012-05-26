mediator = require 'mediator'
View = require 'views/view'

module.exports = class FormView extends View
  autoRender: yes

  initialize: ->
    super
    @delegate 'click', '.save-form-data', @save

  publishSave: (response) ->
    mediator.publish @saveEvent, response if @saveEvent

  save: (event) =>
    @model.save()
      .success (response) =>
        @publishSave response
        @trigger 'dispose'
        @dispose()
