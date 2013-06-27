module.exports = class Layout extends Chaplin.Layout
  initialVisit: true

  listen:
    'dispatcher:dispatch mediator': 'trackVisit'

  trackVisit: =>
    gauges = window._gauges
    if @initialVisit
      gauges?.track_referrer = true
      @initialVisit = false
    gauges?.push ['track']
