"use strict"

require("config/underscore_config.coffee")()

module.exports = '<div class="overlay"></div><div class="popup {{- customClass }}"><div class="popup__close"></div><div class="popup__content">{{= content }}</div></div>'
