window.BlogBackbone =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new BlogBackbone.Routers.Posts()
    Backbone.history.start()

$(document).ready ->
  BlogBackbone.init()
