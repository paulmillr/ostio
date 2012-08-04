mediator = require 'mediator'
View = require 'views/base/view'
SpinnerView = require 'views/spinner_view'

module.exports = class FormView extends View
  tagName: 'form'
  autoRender: yes

  initialize: ->
    super
    @subscribeEvent 'loginStatus', @render
    @delegate 'submit', (event) =>
      event.preventDefault()
      @save event if event.currentTarget.checkValidity()

  publishSave: (response) ->
    mediator.publish @saveEvent, response if @saveEvent

  save: (event) =>
    spinner = new SpinnerView container: @$('.submit-form')
    @model.save()
      .done (response) =>
        console.log 'done'
        @publishSave response
        @trigger 'dispose'
        @dispose()
      .fail (response) =>
        spinner.dispose()
