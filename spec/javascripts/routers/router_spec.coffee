describe 'App.Routers.Router', ()->
  beforeEach ()->
    @router = new App.Routers.Router

  describe '#fooList', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @router.fooList()

    it 'triggers FOO:list', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:list'

  describe '#fooShow', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @router.fooShow(1)

    it 'triggers FOO:show', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:show', 1

  describe '#fooEdit', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @router.fooEdit(1)

    it 'triggers FOO:edit', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:edit', 1

  describe '#fooAdd', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @router.fooAdd()

    it 'triggers FOO:add', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:add'

