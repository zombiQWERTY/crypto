"use strict"

$             = require "jbone"
_             = require "underscore"
Backbone      = require "backbone"
CryptoJS      = require "crypto-js"
Filesaver     = require "browser-filesaver"

Main_template = require "modules/Main/templates/Main_template.coffee"

module.exports = Backbone.View.extend

	el      : "#content"
	template: _.template Main_template

	events:
		"click .back"            : "goTop"
		"click #action-encrypt"  : "crypt"
		"click #action-decrypt"  : "crypt"
		"click .step-two .button": "browse"
		"click .button_process"  : "process"
		"change #encrypt-input"  : "getFileToEncrypt"
		"change #decrypt-input"  : "getFileToDecrypt"

	initialize: ->
		@$el.html @template()

		@badBrowser()

		@limit      = 10

		@$body      = $ "body"
		@$steps     = $ ".steps"
		@$back      = $ ".back"
		@$stepTwo   = $ ".step-two"
		@$stepThree = $ ".step-three"
		@$stepFour  = $ ".step-four"

		@state      = false
		@file       = false
		return

	crypt: (event) ->
		$target = $ event.currentTarget
		if $target.attr("id") == "action-encrypt"
			@$stepTwo.addClass "step-two_encrypt"
			@$stepThree.addClass "step-three_encrypt"
			@$stepFour.addClass "step-four_encrypt"
			@state = "encrypt"
		else if $target.attr("id") == "action-decrypt"
			@$stepTwo.addClass "step-two_decrypt"
			@$stepThree.addClass "step-three_decrypt"
			@$stepFour.addClass "step-four_decrypt"
			@state = "decrypt"
		@step 2
		return

	browse: (event) ->
		$target = $ event.currentTarget
		$input  = $ $target.data "input"
		$($target.data("input"))[0].click()
		return

	getFileToEncrypt: (event) ->
		files = event.target.files
		if files.length != 1
			new Alert
				text: "Выберите один файл для шифрования"
				type: "warning"
			return false
		@file = files[0]
		if @file.size > 1024 * 1024 * @limit
			new Alert
				text: "Максимальный размер шифруемого файла #{@limit}Mb."
				type: "warning"
			return
		@step 3
		return

	getFileToDecrypt: (event) ->
		files = event.target.files
		if files.length != 1
			new Alert
				text: "Выберите один файл для дешифрования"
				type: "warning"
			return false
		@file = files[0]
		@step 3
		return

	process: (event) ->
		$target  = $ event.currentTarget
		$input   = $ $target.data "input"
		$direct  = $ ".button_download"
		self     = @

		password = $input.val()
		$input.val ""
		$direct.off "click.download"

		if password.length < 5
			new Alert
				text: "Ключ должен быть больше пяти символов"
				type: "warning"
			return

		Reader = new FileReader
		if @state == "encrypt"
			Reader.onload = (event) ->
				encrypted = CryptoJS.AES.encrypt event.target.result, password
				filename  = self.file.name + ".encrypted"
				filename  = self.replaceAll filename, " ", "_"
				blob      = new Blob [encrypted], type: "text/plain;charset=utf-8"
				$direct.on "click.download", ->
					Filesaver.saveAs blob, filename
					return
				self.step 4
				return
			Reader.readAsDataURL @file
		else if @state == "decrypt"
			Reader.onload = (event) ->
				decrypted = CryptoJS.AES.decrypt(event.target.result, password).toString CryptoJS.enc.Latin1
				if !/^data:/.test decrypted
					new Alert
						text: "Неверный ключ или не тот файл."
						type: "warning"
					return false
				filename = self.file.name.replace ".encrypted", ""
				blob     = self.dataURItoBlob decrypted
				$direct.on "click.download", ->
					Filesaver.saveAs blob, filename
					return
				self.step 4
				return
			Reader.readAsText @file
		return

	step: (step, callback = ->) ->
		if step == 1
			@$back.fadeOut()
		else
			@$back.fadeTo(0.8, 5)
		@$steps.css "top", -(step - 1) * 100 + "%"
		setTimeout ->
			callback()
			return
		, 400
		return

	goTop: ->
		self = @
		@step 1, ->
			self.state = false
			self.$stepTwo.removeClass "step-two_encrypt step-two_decrypt"
			self.$stepThree.removeClass "step-three_encrypt step-three_decrypt"
			self.$stepFour.removeClass "step-four_encrypt step-four_decrypt"
			return
		return

	dataURItoBlob: (dataURI) ->
		arr = dataURI.split(',')
		mime = arr[0].match(/:(.*?);/)[1]
		bstr = atob(arr[1])
		n = bstr.length
		u8arr = new Uint8Array(n)
		while n--
			u8arr[n] = bstr.charCodeAt(n)
		new Blob([ u8arr ], type: mime)

	replaceAll: (string, find, replace) ->
		string.replace new RegExp(@escapeRegExp(find), "g"), replace

	escapeRegExp: (string) ->
		string.replace /([.*+?^=!:${}()|\[\]\/\\])/g, '\\$1'

	badBrowser: ->
		try
			isFileSaverSupported = !!new Blob
		catch e
			alert
				text: "Обновите браузер." + e
				type: "warning"
		return

	render: ->
		return

