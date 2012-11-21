UsersView = require 'views/user/users_view'
template = require 'views/templates/organization_owners'

module.exports = class OrganizationOwnersView extends UsersView
  listSelector: '.users-list'
  template: template
