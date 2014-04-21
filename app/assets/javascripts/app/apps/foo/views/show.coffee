@App.module 'Foo.Views', (Views, app)->

  class Views.Show extends Marionette.ItemView
    template: JST['foo/show']
    ui:
      editButton: 'button.edit'
      back: '.back'
    events:
      'click button.edit':()->
        app.vent.trigger 'FOO:edit', @model.get('id')
      'click .back':()->
        app.vent.trigger 'FOO:list'
