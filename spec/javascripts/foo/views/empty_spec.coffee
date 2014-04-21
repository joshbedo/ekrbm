describe 'App.Foo.Views.Empty', ()->
  beforeEach ()->
    @view = new App.Foo.Views.Empty

    @view.render()
      

  describe 'clicking on the show list button', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @view.ui.list.click()
      
    it 'fires the FOO:list event', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:list'
