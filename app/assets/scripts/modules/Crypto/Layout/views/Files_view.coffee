"use strict"

Backbone  = require "backbone"
Filesaver = require "browser-filesaver"


module.exports = Backbone.View.extend

	saveToBlob: (content, name) ->
		blob = new Blob [content], type: "text/plain;charset=utf-8"
		Filesaver.saveAs blob, name
		return
