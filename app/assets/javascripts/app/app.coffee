@App = new Marionette.Application()

@App.addRegions
  main: '#main-region'

@App.on 'start', ()->
  console.log 'app starting'
  Backbone.history.start {pushState: true}
