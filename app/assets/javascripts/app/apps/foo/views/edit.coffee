@App.module 'Foo.Views', (Views, app)->

  class Views.Edit extends Marionette.ItemView
    template: JST['foo/edit']
    ui:
      saveButton: 'button.save'
      form: 'form'
      bar: '#bar'
      error: '.alert-danger'
    error: ()->
      @ui.error.show()
    events:
      'click button.save':()->
        @model.set('bar', @ui.bar.val()) 
        app.vent.trigger 'FOO:save', @model
