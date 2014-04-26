describe 'App.Foo.Views.List', ()->
  beforeEach ()->
    @collection = new App.Collections.Foos [
      { bar: 'john'}
      { bar: 'ringo'}
      { bar: 'george'}
      { bar: 'paul'}
    ]
    @view = new App.Foo.Views.List
      collection: @collection

    @view.render()

  describe 'Clicking on the add button', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @view.ui.add.click()
      
    it 'fires the FOO:add event', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:add'
      

  it 'displays all the items', ()->
    expect(@view.$el.html()).toContain 'john'
    expect(@view.$el.html()).toContain 'ringo'
    expect(@view.$el.html()).toContain 'george'
    expect(@view.$el.html()).toContain 'paul'
