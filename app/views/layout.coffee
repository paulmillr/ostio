Chaplin = require 'chaplin'

module.exports = class Layout extends Chaplin.Layout
  initialize: ->
    super
    @subscribeEvent '!router:route', @trackVisit

  trackVisit: =>
    window._gauges.push ['track']
