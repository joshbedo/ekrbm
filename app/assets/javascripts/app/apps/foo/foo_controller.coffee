@App.module 'Foo', (Foo, app)->

  class Foo.Controller
    constructor: ()->
      App.vent.on 'FOO:show', (id)=>
        @show(id)
      App.vent.on 'FOO:list', ()=>
        @list()
      App.vent.on 'FOO:edit', (id)=>
        @edit(id)
      App.vent.on 'FOO:save', (model)=>
        @save(model)
      App.vent.on 'FOO:empty', ()=>
        @empty()
      App.vent.on 'FOO:error', ()=>
        @error()
    _fetch: (id)->
      deferred = $.Deferred (d)=>
        model = new app.Models.Foo({id: id})
        model.fetch().done ()->
          d.resolve(model)
      deferred.promise()
    _save: (model)->
      deferred = $.Deferred (d)=>
        promise = model.save()
        promise.done ()->
          d.resolve(model)
        promise.fail ()->
          d.reject()
      deferred.promise()
    show: (id)->
      @_fetch(id).done (model)->
        app.main.show new Foo.Views.Show
          model: model 
        app.vent.trigger 'NAVIGATE', "foos/#{model.get('id')}"
    save: (model)->
      promise = @_save(model)

      promise.done (res)->
        App.vent.trigger 'FOO:show', res.get('id')
        App.vent.trigger 'NAVIGATE', "foos/#{res.get('id')}"

      promise.fail ()->
        App.vent.trigger 'FOO:error'

    error: ()->
      app.main.currentView.error() if app.main.currentView.error

    edit: (id)->
      @_fetch(id).done (model)->
        app.main.show new Foo.Views.Edit
          model: model 
        app.vent.trigger 'NAVIGATE', "foos/#{model.get('id')}/edit"
    list: (collection)->
      collection = new app.Collections.Foos()
      promise = collection.fetch()
      promise.done (data)->
        app.main.show new Foo.Views.Foos
          collection: collection 
    empty: ()->
      app.main.show new Foo.Views.Empty()
      app.vent.trigger 'NAVIGATE', "foos/list"
      
  Foo.on 'start', ()->
    new Foo.Controller()
