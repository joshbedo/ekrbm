@App.module 'Collections', (Collections, app)->
  class Collections.Foos extends Backbone.Collection
    model: app.Models.Foo
    url: '/foos.json'
