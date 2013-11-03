PageView = require 'views/base/page-view'

module.exports = class HomePageView extends PageView
  autoRender: true
  template: require './templates/home-page'
