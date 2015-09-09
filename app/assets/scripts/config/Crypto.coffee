"use strict"

require("common/functions.coffee")()
require("common/jBoneExtend.coffee")()

$          = require "jbone"
_          = require "underscore"
Backbone   = require "backbone"
Backbone.$ = $

Config     = require "config/Crypto_config.coffee"
Router     = require "config/router_config.coffee"

$ ->
	new Router

	hasPushstate = !!(window.history && history.pushState)
	if hasPushstate
		Backbone.history.start
			pushState: true
			root     : Config().rootUrl
	else
		Backbone.history.start()
	return
