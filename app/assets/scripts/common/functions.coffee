"use strict"

Alert = require "modules/components/Alert/views/Alert_view.coffee"
Popup = require "modules/components/Popup/views/Popup_view.coffee"

module.exports = ->
	window.Alert = Alert
	window.Popup = Popup
	return

