CollectionView = require 'chaplin/views/collection_view'
User = require 'views/user_view'
template = require 'views/templates/users'

module.exports = class UsersView extends CollectionView
  template: template

  getView: (item) ->
    new User model: item
