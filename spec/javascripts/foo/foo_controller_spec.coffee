describe 'Foo.Controller', ()->
  beforeEach ()->
    @model = new App.Models.Foo
      id: 1
    @collection = new App.Collections.Foos [@model]
    @controller = new App.Foo.Controller()

  afterEach ()->
    App.vent._events = {}

  ## trigger tests ##
    
  describe 'App.vent.trigger FOO:show', ()->
    beforeEach ()->
      spyOn @controller, 'show'
      App.vent.trigger 'FOO:show', @model

    it 'show is called', ()->
      expect(@controller.show).toHaveBeenCalledWith @model

  describe 'App.vent.trigger FOO:list', ()->
    beforeEach ()->
      spyOn @controller, 'list'
      App.vent.trigger 'FOO:list'

    it 'show is called', ()->
      expect(@controller.list).toHaveBeenCalled()

  describe 'App.vent.trigger FOO:edit', ()->
    beforeEach ()->
      spyOn @controller, 'edit'
      App.vent.trigger 'FOO:edit', @model.get('id')

    it 'edit is called', ()->
      expect(@controller.edit).toHaveBeenCalledWith @model.get('id')

  describe 'App.vent.trigger FOO:save', ()->
    beforeEach ()->
      spyOn @controller, 'save'
      App.vent.trigger 'FOO:save', @model

    it 'save is called', ()->
      expect(@controller.save).toHaveBeenCalledWith @model

  describe 'App.vent.trigger FOO:empty', ()->
    beforeEach ()->
      spyOn @controller, 'empty'
      App.vent.trigger 'FOO:empty'

    it 'empty is called', ()->
      expect(@controller.empty).toHaveBeenCalled()

  describe 'App.vent.trigger FOO:error', ()->
    beforeEach ()->
      spyOn @controller, 'error'
      App.vent.trigger 'FOO:error'

    it 'error is called', ()->
      expect(@controller.error).toHaveBeenCalled()
      
  ## method tests ##

  describe '#empty', ()->
    beforeEach ()->
      spyOn App.main, 'show'
      spyOn App.vent, 'trigger'
      @controller.empty()

    it 'shows the empty view', ()->
      expect(App.main.show).toHaveBeenCalledWith jasmine.any(App.Foo.Views.Empty)
      
    it 'fires the navigate event', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'NAVIGATE', 'foos/list'

  describe '#show', ()->
    beforeEach ()->
      spyOn App.main, 'show'
      spyOn App.vent, 'trigger'
      spyOn(@controller, '_fetch').andReturn ($.Deferred (d)=> d.resolve(@model)).promise()
      @controller.show(@model.get('id'))

    it 'shows the view', ()->
      expect(App.main.show).toHaveBeenCalledWith jasmine.any(App.Foo.Views.Show)
      
    it 'fires the navigate event', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'NAVIGATE', "foos/#{@model.get('id')}"

  describe '#edit', ()->
    beforeEach ()->
      spyOn App.main, 'show'
      spyOn App.vent, 'trigger'
      spyOn(@controller, '_fetch').andReturn ($.Deferred (d)=> d.resolve(@model)).promise()
      @controller.edit(@model.get('id'))

    it 'shows the view', ()->
      expect(App.main.show).toHaveBeenCalledWith jasmine.any(App.Foo.Views.Edit)
      
    it 'fires the navigate event', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'NAVIGATE', (Routes.edit_foo_path @model.attributes)[1..-1] 

  describe '#save', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
    
    describe 'a successful save', ()->
      beforeEach ()->
        spyOn(@controller, '_save').andReturn ($.Deferred (d)=> d.resolve(@model)).promise()
        @controller.save(@model.get('id'))

      it 'triggers the NAVIGATE event', ()->
        expect(App.vent.trigger).toHaveBeenCalledWith 'NAVIGATE', (Routes.foo_path @model.attributes)[1..-1]

      it 'triggers the FOO:show event', ()->
        expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:show', @model.get('id') 

    describe 'an unsuccessful save', ()->
      beforeEach ()->
        spyOn(@controller, '_save').andReturn ($.Deferred (d)=> d.reject(@model)).promise()
        @controller.save(@model.get('id'))

      it 'triggers the NAVIGATE event', ()->
        expect(App.vent.trigger).not.toHaveBeenCalledWith 'NAVIGATE', (Routes.foo_path @model.attributes)[1..-1]

      it 'triggers the FOO:show event', ()->
        expect(App.vent.trigger).not.toHaveBeenCalledWith 'FOO:show', @model.get('id') 

      it 'shows an error message', ()->
        expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:error'
