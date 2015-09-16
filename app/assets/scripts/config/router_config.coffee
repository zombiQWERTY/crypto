"use strict"

FastClick   = require "fastclick"
$           = require "jbone"
_           = require "underscore"
Backbone    = require "backbone"

Layout_view = require "modules/Crypto/Layout/views/Layout_view.coffee"
Common_view = require "modules/Crypto/Layout/views/Common_view.coffee"
Action_view = require "modules/Crypto/Action/views/Action_view.coffee"


module.exports = Backbone.Router.extend

	routes:
		"*path": "Layout"

	initialize: ->
		new FastClick document.body
		new Common_view
		return

	Layout: ->
		Layout = new Layout_view
		Layout.goto Action_view
		return


