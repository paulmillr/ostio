mediator = require 'mediator'
View = require 'views/view'
socket = require 'lib/socket'

module.exports = class FormView extends View
  autoRender: yes

  initialize: ->
    super
    @subscribeEvent 'loginStatus', @render
    @delegate 'click', '.save-form-data', @save

  publishSave: (response) ->
    return unless @saveEvent
    socket.emit @saveEvent, response
    mediator.publish @saveEvent, response

  save: (event) =>
    @model.save()
      .success (response) =>
        @publishSave response
        @trigger 'dispose'
        @dispose()
