EditPostFormView = require 'views/post/edit-post-form-view'
template = require './templates/post'
View = require 'views/base/view'

module.exports = class PostView extends View
  className: 'post'
  tagName: 'article'
  template: template

  initialize: ->
    super
    @delegate 'click', '.post-edit-button', @editPost
    @delegate 'click', '.post-delete-button', @deletePost

  editPost: (event) =>
    @$('.post-text').remove()
    createNewPost = =>
      container = @$('.post-content')
      editPostView = new EditPostFormView {@model, container}
      editPostView.on 'dispose', @render
      @subview 'editPostForm', editPostView
    createNewPost()

  deletePost: (event) =>
    @model.destroy()
