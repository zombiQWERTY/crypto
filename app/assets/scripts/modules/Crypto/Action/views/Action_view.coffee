"use strict"

$               = require "jbone"
_               = require "underscore"
Backbone        = require "backbone"

Layout_view     = require "modules/Crypto/Layout/views/Layout_view.coffee"
Key_view        = require "modules/Crypto/Key/views/Key_view.coffee"
Decrypt_view    = require "modules/Crypto/Decrypt/views/Decrypt_view.coffee"
Action_template = require "modules/Crypto/Action/templates/Action_template.coffee"

module.exports = Backbone.View.extend

	el      : "#steps"
	template: _.template Action_template
	name    : "Action"

	events  : 
		"click #encrypt": "encrypt"
		"click #decrypt": "decrypt"

	initialize: ->
		@$el.append @template()
		return

	encrypt: ->
		Layout = new Layout_view
		Layout.goto Key_view
		return

	decrypt: ->
		Layout = new Layout_view
		Layout.goto Decrypt_view
		return
