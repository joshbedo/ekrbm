describe 'App.Foo.Views.Show', ()->
  beforeEach ()->
    @model = new App.Models.Foo 
      bar: 'buzz'
      id: 1
    @view = new App.Foo.Views.Show
      model: @model

     
    setFixtures @view.render().el

  it 'shows the bar property', ()->
    expect(@view.$el.html()).toContain @model.get('bar')

  it 'error flag is not showing', ()->
    expect(@view.ui.error).not.toBeVisible()

  it 'counter should be zero', ()->
    expect(@view.ui.counter.html()).toEqual('0')

  describe 'clicking on the edit button', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @view.ui.editButton.click()
      
    it 'fires the FOO:edit event with the model', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:edit', @model.get('id')

  describe 'clicking on the back button', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @view.ui.back.click()
      
    it 'fires the FOO:show event with the model', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:list'

  describe 'clicking on the delete button', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @view.ui.delete.click()
      
    it 'fires the FOO:delete event', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:delete', @model

  describe '#error', ()->
    beforeEach ()->
      @view.error()
      
    it 'error flag is visible', ()->
      expect(@view.ui.error).toBeVisible()

  describe 'clicking on the + counter button', ()->
    beforeEach ()->
      @view.ui.plus.click()
      
    it 'counter value goes to one', ()->
      expect(@view.ui.counter.html()).toEqual('1')

  describe 'clicking on the - counter button', ()->
    beforeEach ()->
      spyOn @view, 'minus'
      @view.ui.minus.click()
      
    it 'minus will be called', ()->
      expect(@view.minus).toHaveBeenCalled()

  describe 'clicking on the - counter button', ()->
    beforeEach ()->
      @view.minus()
      
    it 'counter is -1', ()->
      expect(@view.ui.counter.html()).toEqual("-1")
