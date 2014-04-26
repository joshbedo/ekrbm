@App.module 'Foo.Views', (Views, app)->
  class Views.Foo extends Marionette.ItemView
    template: JST['foo/foo']
    tagName: 'li'
    events:
      'click': ()->
        App.vent.trigger 'FOO:show', @model.get('id')

