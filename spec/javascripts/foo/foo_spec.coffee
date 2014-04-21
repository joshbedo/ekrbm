describe 'Foo.Controller', ()->
  beforeEach ()->
    @model = new App.Models.Foo()
    @collection = new App.Collections.Foos [@model]
    @controller = new App.Foo.Controller()
    
  describe 'App.vent.trigger FOO:show', ()->
    beforeEach ()->
      spyOn @controller, 'show'
      App.vent.trigger 'FOO:show', @model

    it 'show is called', ()->
      expect(@controller.show).toHaveBeenCalledWith @model

  describe 'App.vent.trigger FOO:list', ()->
    beforeEach ()->
      spyOn @controller, 'list'
      App.vent.trigger 'FOO:list', @collection

    it 'show is called', ()->
      expect(@controller.list).toHaveBeenCalledWith @collection
