describe 'App.Foo.Views.Show', ()->
  beforeEach ()->
    @model = new App.Models.Foo 
      bar: 'buzz'
      id: 1
    @view = new App.Foo.Views.Show
      model: @model

    @view.render()
      
  it 'shows the bar property', ()->
    expect(@view.$el.html()).toContain @model.get('bar')

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
