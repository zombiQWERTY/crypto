"use strict"

require("config/underscore_config.coffee")()

module.exports = '
<div class="back"></div>
<div class="steps">
	<div class="step step-one">
		<div class="step__content">
			<h1>Что вы хотите сделать?</h1>
			<div class="button button_encrypt button_green" id="action-encrypt">Зашифровать файл</div>
			<div></div>
			<div class="button button_decrypt button_magenta" id="action-decrypt">Дешифровать файл</div>
		</div>
	</div>
	<div class="step step-two">
		<div class="step__content step__content_encrypt">
			<h1>Выберите файл для шифрования</h1>
			<h2>Будет сгенерирована зашифрованная копия файла.</h2>
			<div class="button button_browse button_blue" data-input="#encrypt-input">Выбрать</div>
			<input type="file" id="encrypt-input" hidden="hidden" />
		</div>
		<div class="step__content step__content_decrypt">
			<h1>Выберите файл для дешифрования</h1>
			<h2>Только файлы, зашифрованные программой Crypto.</h2>
			<div class="button button_browse button_blue" data-input="#decrypt-input">Выбрать</div>
			<input type="file" id="decrypt-input" hidden="hidden" />
		</div>
	</div>
	<div class="step step-three">
		<div class="step__content step__content_encrypt">
			<h1>Введите ключ</h1>
			<h2>Этот ключ будет использован для шифрования, запишите или запомните его. Вы не сможете дешифровать файл без него.</h2>
			<input type="password" id="encrypt-key" />
			<div></div>
			<div class="button button_process button_red" data-input="#encrypt-key">Зашифровать</div>
		</div>
		<div class="step__content step__content_decrypt">
			<h1>Введите ключ</h1>
			<h2>Введите ключ, использованный для шифрования этого файла. Без этого ключа файл расшифровать не удастся.</h2>
			<input type="password" id="decrypt-key" />
			<div></div>
			<div class="button button_process button_red" data-input="#decrypt-key">Дешифровать</div>
		</div>
	</div>
	<div class="step step-four">
		<div class="step__content">
			<h1 class="step__header_encrypt">Файл зашифрован</h1>
			<h1 class="step__header_decrypt">Файл дешифрован</h1>
			<div class="button button_download button_green">Скачать</div>
		</div>
	</div>
</div>
'
