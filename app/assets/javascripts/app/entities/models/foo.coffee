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
    validate: (attrs)->
      errors = []
      errors.push 'must be a number' if attrs.priority == '' || isNaN(attrs.priority)

      if errors.length == 0 then false else errors

