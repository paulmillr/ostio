Chaplin = require 'chaplin'

module.exports = class Layout extends Chaplin.Layout
  initialVisit: yes

  initialize: ->
    super
    @subscribeEvent 'dispatcher:dispatch', @trackVisit

  trackVisit: =>
    gauges = window._gauges
    if @initialVisit
      gauges?.track_referrer = yes
      @initialVisit = no
    gauges?.push ['track']
