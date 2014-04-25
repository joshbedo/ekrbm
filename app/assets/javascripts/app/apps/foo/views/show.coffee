@App.module 'Foo.Views', (Views, app)->

  class Views.Show extends Marionette.ItemView
    template: JST['foo/show']
    ui:
      editButton: 'button.edit'
      back: '.back'
      delete: '.delete'
      error: '.alert-danger'
    error: ()->
      @ui.error.show()
    events:
      'click button.edit':()->
        app.vent.trigger 'FOO:edit', @model.get('id')
      'click .back':()->
        app.vent.trigger 'FOO:list'
      'click .delete':()->
        app.vent.trigger 'FOO:delete', @model
