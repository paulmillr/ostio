CollectionView = require 'views/base/collection-view'
Repo = require 'views/repo/repo-view'

module.exports = class ReposView extends CollectionView
  className: 'user-repo-list'
  itemView: Repo
  tagName: 'ul'
