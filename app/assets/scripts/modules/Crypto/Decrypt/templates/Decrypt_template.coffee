"use strict"

require("config/underscore_config.coffee")()

module.exports = '
<div class="step step-decrypt">
	<div class="step__content">
		<h1>Выберите приватный ключ и файл для дефрования</h1>
		<h2 class="subheader">Будет сгенерирована дешифрованная копия файла.</h2>
		<h2 class="subheader">Введите секретную фразу (или слово), которую Вы использовали при генерации ключей.</h2>
		<input type="password" id="key" />
		<div></div>
		<div class="button button_process button_magenta" id="private-key">Выбрать ключ</div>
		<input type="file" id="key-file" hidden="hidden" />
		<div></div>
		<div class="button button_browse button_blue" id="decrypt">Выбрать файл</div>
		<input type="file" id="decrypt-file" hidden="hidden" />
	</div>
</div>
'
