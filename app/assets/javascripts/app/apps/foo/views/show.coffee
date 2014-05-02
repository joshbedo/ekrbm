@App.module 'Foo.Views', (Views, app)->

  class Views.Show extends Marionette.ItemView
    template: JST['foo/show']
    ui:
      editButton: 'button.edit'
      back: '.back'
      delete: '.delete'
      error: '.alert-danger'
      counter: '.counter'
      plus: '.plus'
      minus: '.minus'
    error: ()->
      @ui.error.show()
    minus: ()->
      @ui.counter.html parseInt(@ui.counter.html()) - 1

    events:
      'click button.edit':()->
        app.vent.trigger 'FOO:edit', @model.get('id')
      'click .back':()->
        app.vent.trigger 'FOO:list'
      'click .delete':()->
        app.vent.trigger 'FOO:delete', @model
      'click .plus':()->
        @ui.counter.html parseInt(@ui.counter.html()) + 1
      'click .minus':()->
        @minus()
