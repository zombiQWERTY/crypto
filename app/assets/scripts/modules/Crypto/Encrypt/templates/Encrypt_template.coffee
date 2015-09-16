"use strict"

require("config/underscore_config.coffee")()

module.exports = '
<div class="step step-encrypt">
	<div class="step__content">
		<h1>Выберите публичный ключ и файл для шифрования</h1>
		<h2>Будет сгенерирована зашифрованная копия файла.</h2>
		<div class="button button_process button_blue" id="public-key">Выбрать ключ</div>
		<input type="file" id="key-file" hidden="hidden" />
		<div></div>
		<div class="button button_browse button_blue" id="encrypt">Выбрать файл</div>
		<input type="file" id="encrypt-file" hidden="hidden" />
	</div>
</div>
'