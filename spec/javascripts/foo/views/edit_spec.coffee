describe 'App.Foo.Views.Edit', ()->
  beforeEach ()->
    @model = new App.Models.Foo 
      bar: 'buzz'
    @view = new App.Foo.Views.Edit
      model: @model

    setFixtures @view.render().el
      
  it 'error should be hidden', ()->
    expect(@view.ui.error).not.toBeVisible()

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
      @view.ui.saveButton.click()
      
    it 'fires the FOO:save event with the model', ()->
      expect(App.vent.trigger).toHaveBeenCalledWith 'FOO:save', @model
