App.module 'Routers', (Routers, app)->
  class Routers.Router extends Backbone.Router
    constructor: ()->
      app.vent.on 'NAVIGATE', (path)=>
        @navigate path
      super()
    routes:{
      '': ()->
        @fooList()
      'foos': ()->
        @fooList
      'foos/:id': (id)->
        @fooShow(id)
      'foos/:id/edit': (id)->
        @fooEdit(id)
    }
    fooList: ()->
      app.vent.trigger 'FOO:list'
    fooShow: (id)->
      app.vent.trigger 'FOO:show', id 
    fooEdit: (id)->
      app.vent.trigger 'FOO:edit', id 

  @on "start", ()->
    app.AppRouter = new Routers.Router()
