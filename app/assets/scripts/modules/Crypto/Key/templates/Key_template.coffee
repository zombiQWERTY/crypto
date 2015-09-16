"use strict"

require("config/underscore_config.coffee")()

module.exports = '
<div class="step step-generate-key">
	<div class="step__content step__content_encrypt">
		<h1>Необходимо сгенерировать ключи (публичный и приватный)</h1>
		<h2 class="subheader">Эти ключи будут использованы для шифрования и дешифрования ваших файлов, сохраните их на компьютер в отдельную папку.</h2>
		<h2 class="subheader">Введите секретную фразу (или слово). Будет использоваться для работы с ключами. Запишите или запомните его.</h2>
		<input type="password" id="key" />
		<div></div>
		<div class="button button_download button_green" id="generate-keys">Сгенерировать</div>
		<div></div>
		<div class="button button_process button_blue" id="keys-exist">У меня уже есть ключи</div>
	</div>
</div>
'
