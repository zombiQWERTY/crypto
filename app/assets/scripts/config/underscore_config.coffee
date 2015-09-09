"use strict"

_ = require "underscore"

module.exports = ->
	_.templateSettings =
		evaluate   : /\{\{(.+?)\}\}/g
		interpolate: /\{\{=(.+?)\}\}/g
		escape     : /\{\{-(.+?)\}\}/g
	return
