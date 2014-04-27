App.module 'Routers', (Routers, app)->
  class Routers.Router extends Backbone.Router
    constructor: ()->
      app.vent.on 'NAVIGATE', (path)=>
        @navigate path
      super()
    routes:{
      '': ()->
        @fooEmpty()
      'foos': ()->
        @fooList()
      'foos/new': ()->
        @fooAdd()
      'foo/list/detail': ()->
        @fooListDetail()
      'foos/:id': (id)->
        @fooShow(id)
      'foos/:id/edit': (id)->
        @fooEdit(id)
    }
    fooEmpty: ()->
      app.vent.trigger 'FOO:empty'
    fooList: ()->
      app.vent.trigger 'FOO:list'
    fooShow: (id)->
      app.vent.trigger 'FOO:show', id 
    fooEdit: (id)->
      app.vent.trigger 'FOO:edit', id 
    fooAdd: ()->
      app.vent.trigger 'FOO:add'
    fooListDetail: ()->
      app.vent.trigger 'FOO:listDetail'

  @on "start", ()->
    app.AppRouter = new Routers.Router()
