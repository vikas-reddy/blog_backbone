class BlogBackbone.Routers.Posts extends Backbone.Router

  routes: {
    '': 'index'
  }

  initialize: ->
    this.posts = new BlogBackbone.Collections.Posts()
    this.posts.fetch()

  index: ->
    postsView = new BlogBackbone.Views.PostsIndex({
      collection: this.posts
    })
    $('#posts-listing').html(postsView.render().el)
