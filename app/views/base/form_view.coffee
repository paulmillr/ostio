View = require 'views/base/view'
SpinnerView = require 'views/spinner_view'

module.exports = class FormView extends View
  tagName: 'form'
  autoRender: yes

  initialize: ->
    super
    @subscribeEvent 'loginStatus', @render
    @delegate 'click', '.cancel-form', @dismiss
    @delegate 'submit', (event) =>
      event.preventDefault()
      @save event if event.currentTarget.checkValidity()

  publishSave: (response) ->
    @publishEvent @saveEvent, response if @saveEvent

  dismiss: (event) =>
    event?.preventDefault()
    @trigger 'dispose'
    @dispose()

  save: (event) =>
    spinner = new SpinnerView container: @$('.submit-form')
    @model.save()
      .done (response) =>
        @publishSave response
        @dismiss()
      .fail (response) =>
        spinner.dispose()
