extends Label

@onready var timer = $"../Timer"


@onready var times_label = $"../TimesLabel"

var words = [" R "," R' ", " L ", " L' ", " M' ", " M ", " U ", " U' ", " F ", " F' ", " B ", " B' ", " D ", " D' ", " R2 ", " L2 ", " U2 "]

var scramble = false


var zeiten = []


var verbote = {

	# R / L / M Achse
	" R ": [" R ", " R' ", " R2 ", " L ", " L' ", " L2 ", " M ", " M' "],
	" R' ": [" R ", " R' ", " R2 ", " L ", " L' ", " L2 ", " M ", " M' "],
	" R2 ": [" R ", " R' ", " R2 ", " L ", " L' ", " L2 ", " M ", " M' "],

	" L ": [" R ", " R' ", " R2 ", " L ", " L' ", " L2 ", " M ", " M' "],
	" L' ": [" R ", " R' ", " R2 ", " L ", " L' ", " L2 ", " M ", " M' "],
	" L2 ": [" R ", " R' ", " R2 ", " L ", " L' ", " L2 ", " M ", " M' "],

	" M ": [" R ", " R' ", " R2 ", " L ", " L' ", " L2 ", " M ", " M' "],
	" M' ": [" R ", " R' ", " R2 ", " L ", " L' ", " L2 ", " M ", " M' "],

	# U / D Achse
	" U ": [" U ", " U' ", " U2 ", " D ", " D' "],
	" U' ": [" U ", " U' ", " U2 ", " D ", " D' "],
	" U2 ": [" U ", " U' ", " U2 ", " D ", " D' "],

	" D ": [" U ", " U' ", " U2 ", " D ", " D' "],
	" D' ": [" U ", " U' ", " U2 ", " D ", " D' "],

	# F / B Achse
	" F ": [" F ", " F' ", " B ", " B' "],
	" F' ": [" F ", " F' ", " B ", " B' "],

	" B ": [" F ", " F' ", " B ", " B' "],
	" B' ": [" F ", " F' ", " B ", " B' "]
}

func generiere_scramble(anzahl):
	var result = []
	
	for i in range(anzahl):
		
		var moeglich = words.duplicate()
		
		
		if result.size() > 0:
			var letztes = result[-1]
			
			if verbote.has(letztes):
				for verbotenes_wort in verbote[letztes]:
					moeglich.erase(verbotenes_wort)
		
		result.append(moeglich.pick_random())
	
	return " ".join(result)

func _ready() -> void:
	text = generiere_scramble(20)

func _on_button_pressed() -> void:
	text = generiere_scramble(20)

func _on_exit_pressed() -> void:
	get_tree().quit()

func _input(event):

	
	if scramble and event.is_action_pressed("ui_accept"):
		
		text = generiere_scramble(20)
		
		# aktuelle Zeit speichern
		var aktuelle_zeit = timer.text
		
		zeiten.append(aktuelle_zeit)
		
		# Zeiten anzeigen
		times_label.text = "\n".join(zeiten)
		
		scramble = false

	
	elif event.is_action_pressed("ui_accept"):
		scramble = true
