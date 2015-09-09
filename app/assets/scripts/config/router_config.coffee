"use strict"

FastClick = require "fastclick"
_         = require "underscore"
Backbone  = require "backbone"

Main_view = require "modules/Main/views/Main_view.coffee"


module.exports = Backbone.Router.extend

	routes:
		"*path": "main"

	initialize: ->
		@layout()
		return

	layout: ->
		new FastClick document.body
		return

	main: ->
		new Main_view
		return
