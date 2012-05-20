View = require 'views/view'
template = require 'views/templates/thread'

module.exports = class ThreadView extends View
  template: template
  className: 'repo-thread'
