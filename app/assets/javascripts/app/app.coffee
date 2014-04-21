@App = new Marionette.Application()

@App.addRegions
  main: '#main-region'

@App.on 'start', ()->
  Backbone.history.start {pushState: true}
