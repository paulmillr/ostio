CollectionView = require 'views/base/collection_view'
Repo = require 'views/repo/repo_view'

module.exports = class ReposView extends CollectionView
  tagName: 'ul'
  className: 'user-repo-list'
  itemView: Repo
