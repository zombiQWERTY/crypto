"use strict"

$            = require "jbone"
_            = require "underscore"
Backbone     = require "backbone"
openpgp      = require "openpgp"

Files_view   = require "modules/Crypto/Layout/views/Files_view.coffee"
Layout_view  = require "modules/Crypto/Layout/views/Layout_view.coffee"
Encrypt_view = require "modules/Crypto/Encrypt/views/Encrypt_view.coffee"
Key_template = require "modules/Crypto/Key/templates/Key_template.coffee"

module.exports = Backbone.View.extend

	el      : "#steps"
	template: _.template Key_template
	name    : "Key"

	events  : 
		"click #keys-exist"   : "encrypt"
		"click #generate-keys": "saveKeys"

	initialize: ->
		@$el.append @template()
		return

	encrypt: ->
		Layout = new Layout_view
		Layout.goto Encrypt_view
		return

	saveKeys: ->
		Files       = new Files_view
		$passphrase = $ "#key"
		passphrase  = $passphrase.val()
		self        = @
		options     = 
			numBits   : 2048
			userId    : "zombiQWERTY"
			passphrase: passphrase

		if passphrase.length < 5
			new Alert
				text: "Ключ должен быть не короче пяти символов."
				type: "warning"
		else
			openpgp.generateKeyPair(options).then (keypair) ->
				Files.saveToBlob keypair.publicKeyArmored, "crypto_public_key.key"
				setTimeout ->
					Files.saveToBlob keypair.privateKeyArmored, "crypto_private_key.key"
					return
				, 100
				new Alert
					text   : "Ключи успешно сгенерированы. Вам осталось их скачать. Через несколько секунд Вы будете перемещены в раздел шифрования."
					type   : "success"
					timeout: 7000
					onClose: ->
						self.encrypt()
						return
				return
			.catch (error) ->
				new Alert
					text: "Ошибка при генерации ключей. " + error
					type: "warning"
				return
		return
