PageView = require 'views/base/page-view'
template = require './templates/home-page'

module.exports = class HomePageView extends PageView
  autoRender: yes
  template: template
