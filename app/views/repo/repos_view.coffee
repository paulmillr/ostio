CollectionView = require 'views/base/collection_view'
Repo = require 'views/repo/repo_view'

module.exports = class ReposView extends CollectionView
  className: 'user-repo-list'
  itemView: Repo
  tagName: 'ul'
