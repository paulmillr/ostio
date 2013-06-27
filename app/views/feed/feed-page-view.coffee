PageView = require 'views/base/page-view'
template = require './templates/feed-page'

module.exports = class FeedPageView extends PageView
  autoRender: true
  template: template
  regions:
    '.user-list-container': 'users'
    '.post-list-container': 'posts'
