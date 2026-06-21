extends Label

var timer_running = false
var start_time = 0
var elapsed_time = 0.0

var can_start = true

func _process(delta):
	if timer_running:
		elapsed_time = (Time.get_ticks_msec() - start_time) / 1000.0
		text = "%.2f" % elapsed_time

func _input(event):

	# START erst beim Loslassen
	if !timer_running and can_start and event.is_action_released("ui_accept"):
		elapsed_time = 0
		start_time = Time.get_ticks_msec()
		timer_running = true

	# STOP sofort beim Drücken
	elif timer_running and event.is_action_pressed("ui_accept"):
		timer_running = false
		can_start = false

	# Nach dem Loslassen wieder startbereit
	elif !timer_running and event.is_action_released("ui_accept"):
		can_start = true
