"use strict"

$               = require "jbone"
_               = require "underscore"
Backbone        = require "backbone"

Layout_template = require "modules/Crypto/Layout/templates/Layout_template.coffee"


module.exports = Backbone.View.extend

	el      : "#content"
	template: _.template Layout_template

	$current: null

	initialize: ->
		@$el.html @template()
		@badBrowser()
		return

	goto: (View, params = "") ->
		$steps    = $ ".steps"
		$previous = @$current or null
		View      = new View params
		$next     = View.$el.find ".step"
		@backShow View.name
		if $previous
			$previous.fadeOut 5, ->
				$previous.remove()
				$next.fadeIn 5
				return
		else
			$next.fadeIn 5
		@$current = $next
		return

	backShow: (viewName) ->
		$back = $ ".back"
		if viewName == "Action"
			$back.fadeOut 5
		else
			$back.fadeIn 5
		return

	replaceAll: (string, find, replace) ->
		string.replace new RegExp(@escapeRegExp(find), "g"), replace

	escapeRegExp: (string) ->
		string.replace /([.*+?^=!:${}()|\[\]\/\\])/g, '\\$1'

	badBrowser: ->
		try
			isFileSaverSupported = !!new Blob
		catch e
			new Alert
				text: "Обновите браузер. " + e
				type: "warning"
		return
