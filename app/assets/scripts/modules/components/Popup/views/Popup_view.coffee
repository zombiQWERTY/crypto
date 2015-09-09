"use strict"

$         = require "jbone"
_         = require "underscore"
Backbone  = require "backbone"

Popup_tpl = require "modules/components/Popup/templates/Popup_tpl.coffee"

class Popup extends Backbone.View

	el      : "#popups"
	template: _.template Popup_tpl

	events:
		"click .overlay": "close"
		"click .popup__close": "close"

	popup : false
	params: {}

	initialize: (params = {}) ->
		try
			if !_.isObject params
				throw new Error "Параметры должны быть в виде объекта."
		catch e
			console.log e

		@paramsCheck params
		@render()
		return

	paramsCheck: (params) ->
		params.customClass = ""              if !params.customClass
		params.content     = ""              if !params.content
		params.onAdd       = new Function()  if !_.isFunction params.onAdd
		params.onClose     = new Function()  if !_.isFunction params.onClose
		@params = params
		return

	render: (params) ->
		try
			self = @
			$popup = @template
				customClass: @params.customClass
				content    : @params.content
			@$popup = $ $popup
			@$el.append @$popup
			@$popup.fadeIn 9, "block", ->
				self.params.onAdd()
				return
		catch e
			console.log e
		return

	get: ->
		@popup

	close: ->
		self = @
		@$popup.fadeOut 9, ->
			self.$popup.remove()
			self.params.onClose()
			return
		return

module.exports = Popup
