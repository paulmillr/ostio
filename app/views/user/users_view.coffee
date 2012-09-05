CollectionView = require 'views/base/collection_view'
User = require 'views/user_view'

module.exports = class UsersView extends CollectionView
  className: 'users'
  itemView: User
