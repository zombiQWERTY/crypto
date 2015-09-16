"use strict"

$                 = require "jbone"
_                 = require "underscore"
Backbone          = require "backbone"

Layout_view       = require "modules/Crypto/Layout/views/Layout_view.coffee"
Files_view        = require "modules/Crypto/Layout/views/Files_view.coffee"
Download_template = require "modules/Crypto/Download/templates/Download_template.coffee"


module.exports = Backbone.View.extend

	el       : "#steps"
	template : _.template Download_template
	name     : "Download"
	params   : []

	events   :
		"click #download": "download"

	initialize: (params) ->
		@params = params
		@$el.append @template
			action: @params[0]
		return


	download: ->
		new Alert
			text: "Всего доброго, приходите ещё=)."
			type: "info"
		Files = new Files_view
		Files.saveToBlob @params[1], @params[2]
		return
