class_name DisplayPrompt
extends Control

@onready var display_prompt: Control = $"."
@onready var prompt_text: Label = %PromptText
@onready var button_sfx: AudioStreamPlayer2D = $ButtonSFX

var accept_callback: Callable
var cancel_callback: Callable
var timeout_callback: Callable
var prompt_timer: SceneTreeTimer


## prompt() takes a string and two callbacks for accepting and cancelling. It reveals the Display
## Prompt component with the string as the prompt. If the user presses the Accept button, it calls
## the accept callback, and if the user presses the Cancel button, it calls the cancel callback.
func prompt(text: String, accept_func: Callable=Callable(), cancel_func: Callable=Callable()) -> void:
	prompt_text.text = text
	accept_callback = accept_func
	cancel_callback = cancel_func
	_show()


## timed_prompt() takes a string, a float, and three callbacks for accepting, cancelling, and timing
## out. It reveals the Display Prompt component with the string as the prompt, with the timer showing
## at the end of the prompt. If the user presses the Accept button, it calls the accept callback. If
## the user presses the Cancel button, it calls the cancel callback. If the user times out, it calls
## the timeout callback.
func timed_prompt(text: String, time: float, accept_func: Callable=Callable(),
	cancel_func: Callable=Callable(), timeout_func: Callable=Callable()) -> void:
	
	accept_callback = accept_func
	cancel_callback = cancel_func
	timeout_callback = timeout_func
	await _timed_show(text, timeout_func, time)


## _reset() deletes the text and resets all variables.
func _reset() -> void:
	prompt_text.text = ""
	accept_callback = Callable()
	cancel_callback = Callable()
	timeout_callback = Callable()
	prompt_timer = null


## _show() reveals the prompt.
func _show() -> void:
	display_prompt.visible = true


## _timed_show() reveals the prompt and sets a timer, which is appended to the prompt text. If the
## timer runs out, the timeout callback is called and the prompt is hidden.
func _timed_show(text: String, timeout_func: Callable, time: float=5) -> void:
	prompt_timer = get_tree().create_timer(time)
	display_prompt.visible = true
	
	while prompt_timer and prompt_timer.time_left > 0:
		display_prompt.prompt_text.text = "%s (%s)" % [text, str(ceili(prompt_timer.time_left))]
		await get_tree().create_timer(.1).timeout

	if not prompt_timer:
		return
	
	_hide()
		
	if timeout_func:
		timeout_func.call()
	
	_reset()


## _hide() hides the prompt.
func _hide() -> void:
	display_prompt.visible = false
	

#region Signals
## Calls the accept callback
func _on_accept_button_pressed() -> void:
	button_sfx.play()
	_hide()
	
	if accept_callback:
		accept_callback.call()
	
	_reset()


## Calls the cancel callback
func _on_cancel_button_pressed() -> void:
	button_sfx.play()
	_hide()
	
	if cancel_callback:
		cancel_callback.call()
	
	_reset()
#endregion
