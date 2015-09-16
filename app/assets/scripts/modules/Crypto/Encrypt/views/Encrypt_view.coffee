"use strict"

$                = require "jbone"
_                = require "underscore"
Backbone         = require "backbone"
openpgp          = require "openpgp"

Layout_view      = require "modules/Crypto/Layout/views/Layout_view.coffee"
Download_view    = require "modules/Crypto/Download/views/Download_view.coffee"
Encrypt_template = require "modules/Crypto/Encrypt/templates/Encrypt_template.coffee"


module.exports = Backbone.View.extend

	el       : "#steps"
	template : _.template Encrypt_template
	name     : "Encrypt"
	publicKey: ""

	events   :
		"click #public-key"    : "processKey"
		"change #key-file"     : "getKey"
		"change #encrypt-file" : "getFile"
		"click #encrypt"       : "processFile"

	initialize: ->
		@$el.append @template()
		return

	getKey: (event) ->
		self  = @
		files = event.target.files
		if files.length != 1
			new Alert
				text: "Выберите один файл, являющийся публичным ключом."
				type: "warning"
		else
			new Alert
				text: "Ключ выбран и обработан."
				type: "info"
			Reader = new FileReader
			Reader.readAsText files[0]
			Reader.onload = (event) ->
				self.publicKey = event.target.result
				return
		return

	getFile: (event) ->
		self   = @
		files  = event.target.files
		if files.length != 1
			new Alert
				text: "Выберите один файл для шифрования."
				type: "warning"
		else
			new Alert
				text: "Файл выбран и скоро будет зашифрован."
				type: "info"
			Layout = new Layout_view
			Reader = new FileReader
			Reader.readAsDataURL files[0]
			filename = Layout.replaceAll files[0].name, " ", "_"
			Reader.onload = (event) ->
				publicKey = openpgp.key.readArmored self.publicKey
				openpgp.encryptMessage(publicKey.keys, event.target.result).then (pgpMessage) ->
					new Alert
						text   : "Файл #{filename} успешно зашифрован."
						type   : "success"
						timeout: 7000
						onAdd: ->
							Layout.goto Download_view, ["encrypt", pgpMessage, "#{filename}.encrypted"]
							return
					return
				.catch (error) ->
					new Alert
						text: "Ошибка: #{error}"
						type: "warning"
					return
				return
		return

	processKey: ->
		$("#key-file")[0].click()
		return

	processFile: ->
		if !@publicKey
			new Alert
				text: "Для начала выберите публичный ключ."
				type: "warning"
		else
			$("#encrypt-file")[0].click()
		return
