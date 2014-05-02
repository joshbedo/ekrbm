@App.module 'Foo.Views', (Views, app)->

  class Views.Edit extends Marionette.ItemView
    template: JST['foo/edit']
    ui:
      saveButton: 'button.save'
      form: 'form'
      bar: '#bar'
      error: '.alert-danger'
      priority: '#priority'
    error: ()->
      @ui.error.show()
    events:
      'click button.save':()->
        @model.set('bar', @ui.bar.val()) 
        @model.set('priority', @ui.priority.val()) 
        app.vent.trigger 'FOO:save', @model if @model.isValid()
