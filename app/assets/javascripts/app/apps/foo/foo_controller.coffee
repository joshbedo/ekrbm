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
      App.vent.on 'FOO:add', ()=>
        @add()
      App.vent.on 'FOO:delete', (model)=>
        @delete model
      App.vent.on 'FOO:listDetail', ()=>
        @_fetchAll().done (coll)->
          app.main.show new App.Foo.Layouts.ListDetail
            collection: coll
            model: coll.first()
          app.vent.trigger 'NAVIGATE', 'foo/list/detail'
    _fetch: (id)->
      deferred = $.Deferred (d)=>
        model = new app.Models.Foo({id: id})
        model.fetch().done ()->
          d.resolve(model)
      deferred.promise()
    _fetchAll: ()->
      coll = new App.Collections.Foos()
      deferred = $.Deferred (d)=>
        coll.fetch().done ()->
          d.resolve(coll)
      deferred.promise()
    _save: (model)->
      deferred = $.Deferred (d)=>
        promise = model.save()
        promise.done ()->
          d.resolve(model)
        promise.fail ()->
          d.reject()
      deferred.promise()
    _delete: (model)->
      deferred = $.Deferred (d)=>
        promise = model.destroy()
        promise.done ()->
          d.resolve()
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

    delete: (model)->
      promise = @_delete(model)

      promise.done (res)->
        App.vent.trigger 'FOO:list'
        App.vent.trigger 'NAVIGATE', Routes.foos_path()[1..-1] 

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
      @_fetchAll().done (coll)->
        app.main.show new Foo.Views.List
          collection: coll 
        app.vent.trigger 'NAVIGATE', Routes.foos_path()[1..-1]

    empty: ()->
      app.main.show new Foo.Views.Empty()
      app.vent.trigger 'NAVIGATE', ""

    add: ()->
      model = new App.Models.Foo()
      app.main.show new Foo.Views.Edit
        model: model 
      app.vent.trigger 'NAVIGATE', Routes.new_foo_path()[1..-1] 
      
  Foo.on 'start', ()->
    new Foo.Controller()
