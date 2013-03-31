Chaplin = require 'chaplin'
utils = require 'lib/utils'
require 'lib/view-helper'

module.exports = class View extends Chaplin.View
  getTemplateFunction: ->
    @template
