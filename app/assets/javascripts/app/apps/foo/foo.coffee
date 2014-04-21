@App.module 'Foo', (Foo, app)->

  class Foo.Controller
    constructor: ()->
      App.vent.on 'FOO:show', (model)=>
        @show(model)
      App.vent.on 'FOO:list', (collection)=>
        @list(collection)

    show: (model)->
      app.main.show new Foo.Views.Show
        model: model 
    list: (collection)->
      app.main.show new Foo.Views.Foos
        collection: collection 
      
  Foo.on 'start', ()->
    new Foo.Controller()
