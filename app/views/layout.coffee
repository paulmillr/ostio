Chaplin = require 'chaplin'

module.exports = class Layout extends Chaplin.Layout
  initialize: ->
    super
    @initialVisit = yes
    @subscribeEvent 'startupController', @trackVisit

  trackVisit: =>
    if @initialVisit
      window._gauges?.track_referrer = yes
      @initialVisit = no
    window._gauges?.push ['track']
