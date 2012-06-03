ChaplinView = require 'chaplin/views/view'
utils = require 'lib/utils'
require 'lib/view_helper'

module.exports = class View extends ChaplinView
  dataset: ['id']

  # Override Chaplin.View::initialize in order to make stuff work.
  initialize: ->
    super

  getTemplateData: ->
    Model = require 'models/model'
    serialize = (object) ->
      result = {}
      for key, value of object
        result[key] = if value instanceof Model
          serialize value.getAttributes()
        else
          value
      result

    modelAttributes = @model and @model.getAttributes()
    templateData = if modelAttributes
      # Return an object which delegates to the returned attributes
      # object so a custom getTemplateData might safely add and alter
      # properties (at least primitive values).
      utils.beget serialize modelAttributes
    else
      {}

    # If the model is a Deferred, add a flag to get the Deferred state
    if @model and typeof @model.state is 'function'
      templateData.resolved = @model.state() is 'resolved'

    templateData

  getTemplateFunction: ->
    @template

  render: ->
    super
    if @model?
      @dataset.forEach (key) =>
        @el.dataset[key] = @model.get(key)
