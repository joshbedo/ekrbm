@App.module 'Foo.Views', (Views, app)->

  class Views.Empty extends Marionette.ItemView
    template: JST['foo/empty']
    ui:
      list: 'button.list'
    events:
      'click button.list':()->
        app.vent.trigger 'FOO:list'
