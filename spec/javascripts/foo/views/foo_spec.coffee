describe 'App.Foo.Views.Foo', ()->
  beforeEach ()->
    @model = new App.Models.Foo()
    @view = new App.Foo.Views.Foo
      model: @model

    @view.render()

  it 'displays the bar property', ()->
    expect(@view.$el.html()).toContain(@model.get('bar'))

  describe 'clicking on an item', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @view.$el.click()

    it 'should fire the show event', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:show', @model.get('id')

