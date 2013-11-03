EditPostFormView = require 'views/post/edit-post-form-view'
template = require './templates/post'
View = require 'views/base/view'

module.exports = class PostView extends View
  className: 'post'
  events:
    'click .post-edit-button': 'editPost'
    'click .post-delete-button': 'deletePost'
  listen:
    'loginStatus mediator': 'render'
  tagName: 'article'
  template: template

  editPost: (event) ->
    text = @find('.post-text')
    icons = @find('.post-icons')
    text.parentNode.removeChild text
    icons.parentNode.removeChild icons
    createNewPost = =>
      container = @find('.post-content')
      editPostView = new EditPostFormView {@model, container}
      editPostView.on 'dispose', @render
      @subview 'editPostForm', editPostView
    createNewPost()

  deletePost: (event) ->
    @model.destroy()
