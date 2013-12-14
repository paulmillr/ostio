View = require 'views/base/view'
template = require './templates/topic'

styles = document.body.style
prop = if 'WebkitTransition' of styles
  'webkitTransitionEnd'
else if 'MozTransition' of styles
  'mozTransitionEnd'
else
  'transitionend'

module.exports = class TopicView extends View
  className: 'repo-topic'
  template: template

  render: ->
    super
    @el.addEventListener prop, @hideOnTransition, false

  hideOnTransition: =>
    if @el.classList.contains('filtered')
      @el.classList.add 'hidden'
    else
      @el.classList.remove 'hidden'
