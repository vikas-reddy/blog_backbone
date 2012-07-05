class BlogBackbone.Views.PostsIndex extends Backbone.View

  index_tmpl: JST['posts/index']
  form_tmpl: JST['posts/_form']
  show_tmpl: JST['posts/show']

  events: {
    'submit #new_post': 'createPost',
    'click .remove_post': 'removePost',
    'click a.edit_post': 'editPost',
    'click .post_cancel': 'cancelPost',
    'click .post_update': 'updatePost'
  }
  
  initialize: ->
    this.collection.on('reset', this.render, this)
  
  render: ->
    $(this.el).html(
      this.index_tmpl({ posts: this.collection }) +
      this.form_tmpl({post: new BlogBackbone.Models.Post()})
    )
    return this
  
  getPostId: (e) ->
    return $(e.target).attr('id').match(/-(\d+)$/)[1]

  createPost: (e) ->
    e.preventDefault()
    
    attributes = {
      title:     $('.post_title', '#new_post').val(),
      body:      $('.post_body', '#new_post').val(),
      published: $('.post_published', '#new_post').is(':checked')
    }
    
    coll = this.collection
    this.collection.create(attributes, {
      wait: false,
      success: ->
        $('#new_post')[0].reset()
        coll.trigger('reset')
      error: this.handleError
    })

  editPost: (e) ->
    e.preventDefault()
    post_id = this.getPostId(e)
    post = this.collection.get(post_id)
    $('#post-' + post_id).html(this.form_tmpl({post: post}))
    return false

  updatePost: (e) ->
    e.preventDefault()
    post_id = this.getPostId(e)
    post = this.collection.get(post_id)

    attributes = {
      title:     $('.post_title', '#edit_post-' + post_id).val(),
      body:      $('.post_body', '#edit_post-' + post_id).val(),
      published: $('.post_published', '#edit_post-' + post_id).is(':checked')
    }
    post.save(attributes, {wait: false, error: this.handleError} )
    this.collection.trigger('reset')
    return false

  removePost: (e) ->
    e.preventDefault()
    if confirm('Are you sure?')
      this.collection.get(this.getPostId(e)).destroy()
      this.collection.trigger('reset')
  
  cancelPost: (e) ->
    e.preventDefault()
    post_id = this.getPostId(e)
    post = this.collection.get(post_id)
    $('#post-' + post_id).html(
      this.show_tmpl({post: post})
    )
    return false

  handleError: (post, response) ->
    if (response.status == 422)
      errors = $.parseJSON(response.responseText).errors
      for attribute of errors
        messages = errors[attribute]
        while i < len
          message = messages[i]
          alert "" + attribute + " " + message
          i++

