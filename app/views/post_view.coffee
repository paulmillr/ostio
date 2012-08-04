View = require 'views/base/view'
EditPostFormView = require 'views/edit_post_form_view'
template = require 'views/templates/post'

module.exports = class PostView extends View
  template: template
  className: 'post'
  tagName: 'article'

  initialize: ->
    super
    @delegate 'click', '.post-edit-button', @editPost
    @delegate 'click', '.post-delete-button', @deletePost

  editPost: (event) =>
    @$previous = @$('.post-text').remove()

    createNewPost = =>
      editPostView = new EditPostFormView
        model: @model,
        container: @$('.post-content'),
        previous: @$previous
      editPostView.on 'dispose', =>
        @render()
      @subview 'editPostForm', editPostView
    createNewPost()

  deletePost: (event) =>
    console.log 'Deleting post...'
