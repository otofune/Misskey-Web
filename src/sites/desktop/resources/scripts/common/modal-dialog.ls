$ = require 'jquery'
require 'jquery.transit'

module.exports = ($title, $content, buttons, can-close = true, on-shown = null) ->
	$buttons = $ '<div class="buttons" />'
	buttons.for-each ($button) ->
		$buttons.append $button

	$body = $ '<p class="body" />'
		..append $content

	$header = $ '<p class="title" />'
		..append $title

	$dialog = $ '<div class="ui-modal-dialog" />'
		..append $header
		..append $body
		..append $buttons

	$container = $ '<div class="ui-modal-dialog-container" />'
		..append $dialog

	$ \body .append $container

	$container.animate {
		opacity: 1
	} 100ms \linear

	$content.css {
		transform: 'scale(1.2)'
		opacity: 0
	}
	$content.transition {
		opacity: \1
		scale: \1
	} 1000ms 'cubic-bezier(0, 1, 0, 1)'

	if on-shown?
		on-shown!

	if can-close
		$container.click ->
			close!

	$dialog.click (e) ->
		e.stop-immediate-propagation!

	function close
		$container.animate {
			opacity: 0
		} 100ms \linear -> $container.remove!
		$dialog.stop!
		$dialog.transition {
			opacity: \0
			scale: \0.8
		} 1000ms 'cubic-bezier(0, 1, 0, 1)' ->
			$dialog.remove!
