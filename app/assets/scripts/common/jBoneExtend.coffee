"use strict"

_        = require "underscore"
jBone    = require "jbone"

module.exports = ->

	jBone.fn.fadeIn = (time = 9, display = "block", callback = ->) ->
		el = @
		isArray el, (element) ->
			el = element  if element
			styles  = el.style
			styles.opacity = 0
			styles.display = display
			fade = ->
				val = parseFloat styles.opacity
				if !((val += parseFloat(".0#{time}")) > 1)
					styles.opacity = val
					requestAnimationFrame fade
				else
					styles.opacity = 1
					callback()
				return
			fade()
		this

	jBone.fn.fadeTo = (to = 0.8, time = 9, display = "block", callback = ->) ->
		el = @
		isArray el, (element) ->
			el = element  if element
			styles  = el.style
			styles.opacity = 0
			styles.display = display
			fade = ->
				val = parseFloat styles.opacity
				if !((val += parseFloat(".0#{time}")) > 1 or val <= to)
					styles.opacity = val
					requestAnimationFrame fade
				else
					styles.opacity = ""
					callback()
				return
			fade()
		this

	jBone.fn.fadeOut = (time = 9, callback = ->) ->
		el = @
		isArray el, (element) ->
			el = element  if element
			styles  = el.style
			styles.opacity = 1
			fade = ->
				if (styles.opacity -= parseFloat(".0#{time}")) < 0.1
					styles.display = "none"
					callback()
				else
					requestAnimationFrame fade
				return
			fade()
		this

	jBone.fn.slideToggle = ->
		el = @
		isArray el, (element) ->
			el = element  if element
			el.classList.toggle "collapsed"
			return
		this

	jBone.fn.hide = ->
		el = @
		isArray el, (element) ->
			el = element  if element
			el.style.display = "none"
		this

	jBone.fn.show = (display = "") ->
		el = @
		isArray el, (element) ->
			el = element  if element
			el.style.display = display
		this

	jBone.fn.text = (string) ->
		el = @
		isArray el, (element) ->
			el = element  if element
			if string
				if !_.isUndefined .el.textContent
					el.textContent = string
				else
					el.innerText = string
				returned = el
			else
				returned = el.textContent || el.innerText
			returned

	isArray = (array, callback = ->) ->
		if isArrayLike array
			_.each array, (element, index, list) ->
				callback element
			array
		else
			callback()

	isArrayLike = (x) ->
		if x instanceof Array
			return true
		if !("length" of x)
			return false
		if typeof x.length != "number"
			return false
		if x.length < 0
			return false
		if x.length > 0
			if !((x.length-1) of x)
				return false
		true

	String::toDOM = ->
		d = document
		a = d.createElement "div"
		b = d.createDocumentFragment()
		a.innerHTML = @
		while i = a.firstChild
			b.appendChild i
		b

	String::trim = ->
		@replace /^\s+|\s+$/g, ""

	return
