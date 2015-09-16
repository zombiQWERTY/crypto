"use strict"

$           = require "jbone"
_           = require "underscore"
Backbone    = require "backbone"

Layout_view = require "modules/Crypto/Layout/views/Layout_view.coffee"
Action_view = require "modules/Crypto/Action/views/Action_view.coffee"


module.exports = Backbone.View.extend

	el: "#content"

	events:
		"click .back": "toTop"

	initialize: ->
		return

	toTop: ->
		Layout = new Layout_view
		Layout.goto Action_view
		return

