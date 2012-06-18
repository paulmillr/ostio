PageView = require 'views/base/page_view'
template = require 'views/templates/home_page'

module.exports = class HomePageView extends PageView
  template: template
  autoRender: yes
