View = require 'views/base/view'
SpinnerView = require 'views/spinner-view'

module.exports = class FormView extends View
  autoRender: yes
  events:
    'click .cancel-form': 'dismiss'
    'submit': 'submit'
  listen:
    'loginStatus mediator': 'render'
  tagName: 'form'

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
      .always (response) =>
        spinner.dispose()

  submit: (event) =>
    event.preventDefault()
    @save event if event.currentTarget.checkValidity()
