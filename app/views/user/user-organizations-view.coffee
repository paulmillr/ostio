UsersView = require 'views/user/users-view'
template = require './templates/user-organizations'

module.exports = class UserOrganizationsView extends UsersView
  listSelector: '.users-list'
  template: template
