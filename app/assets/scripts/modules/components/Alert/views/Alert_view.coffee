"use strict"

$         = require "jbone"
_         = require "underscore"
Backbone  = require "backbone"

Alert_tpl = require "modules/components/Alert/templates/Alert_tpl.coffee"

class Alert extends Backbone.View

	el      : "#alerts"
	template: _.template Alert_tpl

	events:
		"click .alert__close": "targetClose"

	alert : false
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
		params.type    = "info"          if !params.type
		params.text    = ""              if !params.text
		params.time    = 5000            if !params.time
		params.onAdd   = new Function()  if !_.isFunction params.onAdd
		params.onClose = new Function()  if !_.isFunction params.onClose
		@params = params
		return

	render: ->
		try
			if _.indexOf(["info", "warning", "success"], @params.type) == -1
				throw new Error "Алерт может быть следующих типов: info, warning, success."
			$alert = @template
				type: @params.type
				text: @params.text
			@$alert = $ $alert
			@$el.append @$alert
			@timeout()
			@params.onAdd()
		catch e
			console.log e
		return

	get: ->
		@alert

	targetClose: (event) ->
		@close event.currentTarget
		return

	close: ->
		self = @
		@$alert.fadeOut 9, ->
			self.$alert.remove()
			self.params.onClose()
			return
		return

	timeout: ->
		self = @
		setTimeout ->
			self.close @$alert
			return
		, @params.time
		return

module.exports = Alert
