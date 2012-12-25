View = require 'views/base/view'
template = require './templates/topic'

module.exports = class TopicView extends View
  className: 'repo-topic'
  template: template
