describe 'App.Foo.Views.Foos', ()->
  beforeEach ()->
    @collection = new App.Collections.Foos [
      { bar: 'john'}
      { bar: 'ringo'}
      { bar: 'george'}
      { bar: 'paul'}
    ]
    @view = new App.Foo.Views.Foos
      collection: @collection

    @view.render()

  it 'displays all the items', ()->
    expect(@view.$el.html()).toContain 'john'
    expect(@view.$el.html()).toContain 'ringo'
    expect(@view.$el.html()).toContain 'george'
    expect(@view.$el.html()).toContain 'paul'
