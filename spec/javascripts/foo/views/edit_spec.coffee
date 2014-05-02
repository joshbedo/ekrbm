describe 'App.Foo.Views.Edit', ()->
  beforeEach ()->
    @model = new App.Models.Foo 
      bar: 'buzz'
      priority: 7
    @view = new App.Foo.Views.Edit
      model: @model

    setFixtures @view.render().el
      
  it 'error should be hidden', ()->
    expect(@view.ui.error).not.toBeVisible()

  it 'priority is set to 7', ()->
    expect(@view.ui.priority.val()).toEqual('7')

  describe 'Bar input field', ()->
    it 'value is the bar property', ()->
      expect(@view.ui.bar.val()).toEqual @model.get('bar')

  describe '#error', ()->
    beforeEach ()->
      @view.error()

    it 'error', ()->
      expect(@view.ui.error).toBeVisible()

  describe 'clicking on the save button', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @view.ui.priority.val(99)
      @view.ui.saveButton.click()
      
    it 'fires the FOO:save event with the model', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:save', @model

    it 'the priority of the model is set', ()->
      expect(@model.get('priority')).toEqual('99')

  describe 'attempting to save invalid data', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @view.ui.priority.val('xyz')
      @view.ui.saveButton.click()
      
    it 'does not fire the FOO:save event with the model', ()->
      expect(App.vent.trigger).not.toHaveBeenCalledWith 'FOO:save', @model

  describe 'attempting to save invalid data', ()->
    beforeEach ()->
      spyOn App.vent, 'trigger'
      @view.ui.priority.val('')
      @view.ui.saveButton.click()
      
    it 'does not fire the FOO:save event with the model', ()->
      expect(App.vent.trigger).not.toHaveBeenCalledWith 'FOO:save', @model
