"use strict"

require("config/underscore_config.coffee")()

module.exports = '<div class="alert {{- "alert_" + type }}"><div class="alert__message">{{- text }}</div><div class="alert__close"></div></div>'
