UsersView = require 'views/user/users-view'
template = require './templates/organization-owners'

module.exports = class OrganizationOwnersView extends UsersView
  listSelector: '.users-list'
  template: template
