"use strict"

Backbone  = require "backbone"
Filesaver = require "browser-filesaver"


module.exports = Backbone.View.extend

	saveToBlob: (content, name) ->
		mime = []
		expr = /data:(.+?);.*/
		if !expr.test content
			blob = new Blob [content], type: "text/plain;charset=utf-8"
			Filesaver.saveAs blob, name
		else
			mime    = expr.exec(content)[1]
			content = content.replace "data:#{mime};base64,", ""
			blob = new Blob [str2bytes(content)], type: "octet/stream"
			Filesaver.saveAs blob, name
		return

	str2bytes = (base64) ->
		binaryString = window.atob(base64)
		binaryLen = binaryString.length
		bytes = new Uint8Array(binaryLen)
		i = 0
		while i < binaryLen
			ascii = binaryString.charCodeAt(i)
			bytes[i] = ascii
			i++
		bytes

