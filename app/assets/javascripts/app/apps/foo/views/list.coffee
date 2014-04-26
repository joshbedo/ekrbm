@App.module 'Foo.Views', (Views, app)->

  class Views.List extends Marionette.CompositeView
    ui:
      add: '.add'
    events:
      'click .add': ()->
        App.vent.trigger 'FOO:add'

    itemView: Views.Foo
    itemViewContainer: 'ul'
    template: JST['foo/foos']
