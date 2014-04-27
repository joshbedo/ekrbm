describe 'App.Foo.Views.ListDetailLayout', ()->
  beforeEach ()->
    @model =  new App.Models.Foo
      bar: 'one' 
    @collection = new App.Collections.Foos [
        @model
        { bar: 'two' }
        { bar: 'three' }
    ]
    @layout = new App.Foo.Layouts.ListDetail
      collection: @collection 
      model: @model

  it 'has two regions list and detail', ()->
    expect(@layout.list).toBeTruthy()
    expect(@layout.detail).toBeTruthy()
    
  describe 'onRender', ()->
    beforeEach ()->
      spyOn @layout.list, 'show'
      @layout.render()

    it 'list is rendered', ()->
      expect(@layout.list.show).toHaveBeenCalled()

