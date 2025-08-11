class_name SlidingTextBox
extends MarginContainer

@export var max_queue : int = 3

@export var horizontal_text_alignment : HorizontalAlignment = HORIZONTAL_ALIGNMENT_LEFT
@export var vertical_text_alignment : VerticalAlignment = VERTICAL_ALIGNMENT_TOP

@export var fade_out_last_wait_time : float = 3

@export var fade_out_duration : float = 1
@export var fade_out_transition_type : Tween.TransitionType = Tween.TRANS_CUBIC
@export var fade_out_ease_type : Tween.EaseType = Tween.EASE_OUT

@export var enter_in_duration : float = 1
@export var enter_in_transition_type : Tween.TransitionType = Tween.TRANS_CUBIC
@export var enter_in_ease_type : Tween.EaseType = Tween.EASE_OUT

var label_list : Array[RichTextLabel]

var placeholder_label : RichTextLabel

var text_queue : Array[String]

var vboxcontainer: VBoxContainer

var fade_out_last_timer : Timer

var last_filled_index : int = 0

var current_tween : Tween

var _text_entering : bool = false

func _ready() -> void:
	_initialize_vbox()
	_initialize_labels()
	_initialize_timer()

func _process(delta: float) -> void:	
	_process_text_queue()
	
func _process_text_queue():
	if text_queue.is_empty() or _text_entering:
		return
		
	if last_filled_index >= max_queue:
		fade_out_first()
		placeholder_label.text = text_queue.front()
		return
		
	var text = text_queue.pop_front()
	
	label_list[last_filled_index].text = text
	label_list[last_filled_index].visible = true
	
	if last_filled_index < max_queue - 1:
		enter_index(last_filled_index)
	
	last_filled_index += 1
	
	fade_out_last_timer.start()

func add_text_to_queue(text : String) -> void:
	text_queue.append(text)

func enter_index(index : int) -> void:
	_text_entering = true
	
	var label : RichTextLabel = label_list[index] as RichTextLabel
	
	if current_tween:
		current_tween.kill()
		
	current_tween = create_tween()
	current_tween.parallel().tween_property(placeholder_label, "size_flags_stretch_ratio", max_queue + 1 - index, enter_in_duration).from(0).set_ease(enter_in_ease_type).set_trans(enter_in_transition_type)
	
	current_tween.parallel().tween_property(label, "size_flags_vertical", RichTextLabel.SIZE_FILL, enter_in_duration).from(RichTextLabel.SIZE_EXPAND_FILL)
	current_tween.parallel().tween_property(placeholder_label, "size_flags_vertical", RichTextLabel.SIZE_FILL, enter_in_duration).from(RichTextLabel.SIZE_EXPAND_FILL)
	
	current_tween.tween_callback(enter_finish)

func fade_out_first() -> void:
	_text_entering = true
	
	var first : RichTextLabel = label_list[0]
	
	if current_tween:
		if current_tween.is_running():
			return
		current_tween.kill()
	
	var size_x : float = first.size.x
	var size_y : float = first.size.y
	
	current_tween = create_tween()
	
	current_tween.parallel().tween_property(first, "visible", false, fade_out_duration).from(true)
	current_tween.parallel().tween_property(first, "custom_minimum_size", Vector2(size_x, 0), fade_out_duration).from(Vector2(size_x, size_y)).set_ease(fade_out_ease_type).set_trans(fade_out_transition_type)
	current_tween.parallel().tween_property(first, "modulate", Color(1, 1, 1, 0), fade_out_duration).from(Color(1, 1, 1, 1)).set_ease(fade_out_ease_type).set_trans(fade_out_transition_type)
	
	current_tween.tween_callback(remove_first)
	current_tween.tween_callback(enter_finish)

	first.fit_content = false

func enter_finish() -> void:
	_text_entering = false

func remove_first() -> void:
	var first : RichTextLabel = label_list.front() as RichTextLabel
	var last : RichTextLabel = label_list.back() as RichTextLabel
	
	for index in label_list.size() - 1:
		label_list[index].text = label_list[index + 1].text

	first.modulate = Color(1, 1, 1, 1)
	first.fit_content = true
	first.visible = true
	
	last.text = placeholder_label.text
	placeholder_label.text = ""
	last_filled_index -= 1

func _initialize_vbox() -> void:	
	vboxcontainer = VBoxContainer.new()
	add_child(vboxcontainer)
	
func _initialize_labels() -> void:
	for i in max_queue:
		var label : RichTextLabel = RichTextLabel.new()
		
		set_label_properties(label)
		
		label.visible = false
		
		vboxcontainer.add_child(label)
		label_list.append(label)
		
	placeholder_label = RichTextLabel.new()
	set_label_properties(placeholder_label)
	vboxcontainer.add_child(placeholder_label)

func _initialize_timer() -> void:
	fade_out_last_timer = Timer.new()
	
	fade_out_last_timer.wait_time = fade_out_last_wait_time
	fade_out_last_timer.autostart = false
	fade_out_last_timer.one_shot = false
	
	add_child(fade_out_last_timer)
	
	fade_out_last_timer.timeout.connect(_on_fade_out_timer_timeout)

func set_label_properties(label : RichTextLabel) -> void:
	label.bbcode_enabled = true
	label.fit_content = true
	label.scroll_active = false
	
	label.horizontal_alignment = horizontal_text_alignment
	label.vertical_alignment = vertical_text_alignment

func _on_fade_out_timer_timeout() -> void:
	fade_out_first()
