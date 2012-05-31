UsersView = require 'views/users_view'
template = require 'views/templates/organization_owners'

module.exports = class OrganizationOwnersView extends UsersView
  template: template
