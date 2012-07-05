class BlogBackbone.Models.Post extends Backbone.Model

  initialize: ->
    console.log('Post initialize')

  defaults: {
    title: '',
    body: '',
    published: false
  }
