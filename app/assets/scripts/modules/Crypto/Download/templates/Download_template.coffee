"use strict"

require("config/underscore_config.coffee")()

module.exports = '
<div class="step step-download">
	<div class="step__content">
{{ if(action == "encrypt") { }}
		<h1>Файл зашифрован</h1>
{{ } else { }}
		<h1>Файл дешифрован</h1>
{{ } }}
		<div class="button button_download button_green" id="download">Скачать</div>
	</div>
</div>
'
