CollectionView = require 'views/base/collection-view'
User = require 'views/user/user-view'

module.exports = class UsersView extends CollectionView
  className: 'users'
  itemView: User
