@App.module 'Models', (Models, app)->
  class Models.Foo extends Backbone.Model
    defaults:
      bar: 'bazz'
    url: ()->
      "/foos/#{@get('id')}.json"
    toJSON: ()->
      attrs = _.clone(@attributes)
      delete attrs.created_at
      delete attrs.updated_at
      foo: attrs
