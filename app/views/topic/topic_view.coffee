View = require 'views/base/view'
template = require 'views/templates/topic'

module.exports = class TopicView extends View
  className: 'repo-topic'
  template: template
