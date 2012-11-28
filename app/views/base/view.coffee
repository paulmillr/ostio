Chaplin = require 'chaplin'
utils = require 'lib/utils'
require 'lib/view-helper'

module.exports = class View extends Chaplin.View
  # Override Chaplin.View::initialize in order to make stuff work.
  initialize: ->
    super

  getTemplateFunction: ->
    @template
