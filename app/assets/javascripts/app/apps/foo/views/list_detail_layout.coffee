@App.module 'Foo.Layouts', (Layouts, app) ->

  class Layouts.ListDetail extends Marionette.Layout
    initialize: (options)->
      @collection = options.collection
      @model = options.model
    template: JST['foo/list_detail']
    regions:
      list: '.list'
      detail: '.detail'

    onRender: ()->
      @list.show new app.Foo.Views.List
        collection: @collection 
      @detail.show new app.Foo.Views.Show
        model: @model
