UsersView = require 'views/user/users-view'
template = require 'views/templates/user-organizations'

module.exports = class UserOrganizationsView extends UsersView
  listSelector: '.users-list'
  template: template
