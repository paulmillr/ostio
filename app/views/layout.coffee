module.exports = class Layout extends Chaplin.Layout
  initialVisit: true

  listen:
    'dispatcher:dispatch mediator': 'trackVisit'

  # Enable tracking with Gaug.es.
  trackVisit: ->
    gauges = window._gauges
    if @initialVisit
      gauges?.track_referrer = true
      @initialVisit = false
    gauges?.push ['track']
