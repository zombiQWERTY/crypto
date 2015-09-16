"use strict"

require("config/underscore_config.coffee")()

module.exports = '
<div class="step step-action">
	<div class="step__content">
		<h1>Что вы хотите сделать?</h1>
		<div class="button button_encrypt button_green" id="encrypt">Зашифровать файл</div>
		<div></div>
		<div class="button button_decrypt button_magenta" id="decrypt">Дешифровать файл</div>
	</div>
</div>
'
