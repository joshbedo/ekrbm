@App.module 'Models', (Models, app)->
  class Models.Foo extends Backbone.Model
    url: ()->
      return "/foos.json" if @isNew()
      "/foos/#{@get('id')}.json"
    toJSON: ()->
      attrs = _.clone(@attributes)
      delete attrs.created_at
      delete attrs.updated_at
      foo: attrs
