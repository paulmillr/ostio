View = require 'views/base/view'
SpinnerView = require 'views/spinner-view'
mediator = require 'mediator'

module.exports = class FormView extends View
  autoRender: true
  events:
    'click .cancel-form': 'dismiss'
    'submit': 'submit'
  listen:
    'loginStatus mediator': 'render'
  tagName: 'form'

  publishSave: (response) ->
    throw new Error 'FormView must have saveEvent defined' unless @saveEvent
    @publishEvent @saveEvent, response if @saveEvent

  dismiss: (event) ->
    event?.preventDefault()
    @trigger 'dispose'
    @dispose()

  save: ->
    # spinner = new SpinnerView container: @find('.submit-form')
    # dispose = (response) => spinner.dispose()
    # @model.save()
    #   .then (response) =>
    #     @publishSave response
    #     @dismiss()
    #     dispose()
    #   , dispose
    clone = @model.clone()
    clone.set user: mediator.user.clone()
    clone.save().then null, (error) =>
      console.error 'error'
    @publishSave clone
    @dismiss()

  submit: (event) ->
    event.preventDefault() if event
    @save() if @el.checkValidity()
