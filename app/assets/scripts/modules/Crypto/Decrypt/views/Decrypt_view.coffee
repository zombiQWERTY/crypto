"use strict"

$                = require "jbone"
_                = require "underscore"
Backbone         = require "backbone"
openpgp          = require "openpgp"

Layout_view      = require "modules/Crypto/Layout/views/Layout_view.coffee"
Download_view    = require "modules/Crypto/Download/views/Download_view.coffee"
Decrypt_template = require "modules/Crypto/Decrypt/templates/Decrypt_template.coffee"


module.exports = Backbone.View.extend

	el        : "#steps"
	template  : _.template Decrypt_template
	name      : "Decrypt"
	privateKey: ""
	key       : ""

	events   :
		"click #private-key"   : "processKey"
		"change #key-file"     : "getKey"
		"change #decrypt-file" : "getFile"
		"click #decrypt"       : "processFile"

	initialize: ->
		@$el.append @template()
		return

	getKey: (event) ->
		@writeKey()
		if !@key
			new Alert
				text: "Введите секретную фразу (или слово), которую Вы использовали при генерации ключей."
				type: "warning"
		else
			if @key.length < 5
				new Alert
					text: "Ключ должен быть не короче пяти символов."
					type: "warning"
			else
				self  = @
				files = event.target.files
				if files.length != 1
					new Alert
						text: "Выберите один файл, являющийся приватным ключом."
						type: "warning"
				else
					new Alert
						text: "Ключ выбран и обработан."
						type: "info"
					Reader = new FileReader
					Reader.readAsText files[0]
					Reader.onload = (event) ->
						self.privateKey = event.target.result
						return
		return

	getFile: (event) ->
		@writeKey()
		if !@key
			new Alert
				text: "Введите секретную фразу (или слово), которую Вы использовали при генерации ключей."
				type: "warning"
		else
			if @key.length < 5
				new Alert
					text: "Ключ должен быть не короче пяти символов."
					type: "warning"
			else
				self   = @
				Layout = new Layout_view
				files  = event.target.files
				if files.length != 1
					new Alert
						text: "Выберите один файл для дефрования."
						type: "warning"
				else
					new Alert
						text: "Файл выбран и скоро будет дешифрован."
						type: "info"
					Reader = new FileReader
					Reader.readAsDataURL files[0]
					Reader.onload = (event) ->
						privateKey = openpgp.key.readArmored(self.privateKey).keys[0]
						privateKey.decrypt self.key
						pgpMessage = event.target.result
						try
							pgpMessage = openpgp.message.readArmored pgpMessage
						catch error
							console.log error
							setTimeout ->
								window.location = "/"
								return
							, 2000
						openpgp.decryptMessage(privateKey, pgpMessage).then (dataURL) ->
							filename = Layout.replaceAll files[0].name, ".encrypted", ""
							new Alert
								text   : "Файл #{filename} успешно расшифрован."
								type   : "success"
								timeout: 7000
								onAdd: ->
									Layout.goto Download_view, ["decrypt", dataURL, filename]
									return
							return
						.catch (error) ->
							new Alert
								text: "Ошибка: #{error}"
								type: "warning"
							return
		return

	processKey: ->
		$("#key-file")[0].click()
		return

	processFile: ->
		if !@privateKey
			new Alert
				text: "Для начала выберите приватный ключ."
				type: "warning"
		else
			$("#decrypt-file")[0].click()
		return

	writeKey: ->
		$passphrase = $ "#key"
		passphrase  = $passphrase.val()
		@key        = passphrase
		return
