extends Node2D

# http://sotovaya.com/notes-1---0.html

# sample time = 1.50s
var scatman = "8b1 16b1 32- 8b1 16b1 32- 8b1 2d2 16- 16.#c2 16- 8d2 16- 16#c2 8b1 16- 8#f1 2- 16#c2 8- 16.d2 16- 16#c2 16b1 8- 8#f1 2- 2d2 16- 16#c2 8- 16.d2 16- 16#c2 16.a1 16- 8e1 2- 16#c2 8- 16.d2 16- 16#c2 16b1 8- 4b1 2-"
var d_d = "16c2 16d2 16c2 16b1 16c2 16d2 16e2 16f2 16g2 16- 16e2 16- 8e2 16- 32- 32e2 16a2 16- 16f2 16- 8f2 16- 16f2 16g2 16- 16e2 16- 8e2 8- 16c2 16d2 16c2 16b1 16c2 16d2 16e2 16f2 16g2 16- 16e2 16- 8e2 8- 16#f2 16e2 8d2 16#f2 16e2 8d2 4g2"
var animals = "8e2 8d2 8c2 8d2 8e2 4e2 4f2 16- 8c2 4c2 8b1 4b1 2e2 4- 8c2 8b1 8a1 8b1 8c2 4c2 4d2 16- 8a1 4a1 8#g1 4#g1 2e1 4-"
var mario = ""
var snegurochka = "8e2 8e2 8g2 8g2 4f2 8f2 8f2 8a2 4a2 2g2 8- 8e2 8e2 8g2 8g2 4g2 8f2 8f2 8a2 4a2 2g2 8- 8e2 8e2 8e2 8e2 4e2 8c2 8c2 8d2 4d2 2c2 8- 8e2 8e2 8e2 8e2 4e2 8c2 8c2 4c2 4b1 4c2"
var bremen = "8g1 8g1 8g1 8a1 8b1 8b1 8g1 8b1 4d2 4b1 4d2 4- 8c2 8c2 8c2 8b1 8a1 8a1 8c2 8e2 4d2 4c2 4d2 4- 4b1 8- 8c2 4d2 4b1 8e2 8e2 8e2 8f#2 4g2 4e2 8a2 8a2 8a2 8g2 8f#2 8d2 8f#2 8a2 4g2 4f#2 4e2"
var shit_on_you = "16#g1 16#d2 16#c2 16e2 8#d2 16#d2 16b1 16#c2 16#d2 8e2 16#d2 2#g1 16#g1 16#d2 16#c2 16e2 4#d2 16#c2 16b1 8#a1 16b1 2#f1 16#g1 16#d2 16#c2 16e2 8#d2 16#d2 16b1 16#c2 16#d2 8e2 16#d2 4#f1 16- 16- 8#g1 16#a1 16b1 8#c2 16b1 4#g1 16- 16#g1 16b1 16#a1 16#g1 8#f1 2#g1"
var brigada = "16#g1 16#d2 16#c2 16e2 8#d2 16#d2 16b1 16#c2 16#d2 8e2 16#d2 2#g1 16#g1 16#d2 16#c2 16e2 4#d2 16#c2 16b1 8#a1 16b1 2#f1 16#g1 16#d2 16#c2 16e2 8#d2 16#d2 16b1 16#c2 16#d2 8e2 16#d2 4#f1 16- 16- 8#g1 16#a1 16b1 8#c2 16b1 4#g1 16- 16#g1 16b1 16#a1 16#g1 8#f1 2#g1"
var blood_group = "4a2 4#g2 8#f2 8#f2 4- 8#c3 8#c3 8#c3 4#f2 4#f2 8#f2 8#f2 8#g2 4a2 8#g2 8#g2 4- 8#c3 8#c3 8#c3 8#g2 2- 8#g2 8#g2 4a2 8a2 8#f2 8a2 4a2 8a2 4#f2 2- 8#g2 8a2 2#g2 2e2 2#c2"
var kan = "8b0 4e1 8- 8#f1 4g1 8- 8b0 16e1 16- 8#f1 16g1 16- 8c2 16b1 16- 8e1 16g1 16- 8b1 2#a1 8- 16a1 16g1 16e1 16d1 2e1 4- 8e2 16- 16d2 8b1 16- 16a1 8g1 16- 16e1 8a1 8- 8a1 8- 8a1 8- 8a1 8- 16g1 16e1 16d1 2e1 16-"
var ninja_turtles_theme = "4- 8g2 8a2 8g2 8a2 8g2 16a2 8g2 16- 8a2 8#a2 8c3 8#a2 8c3 8#d3 16c3 8#a2 16- 8c3 8f3 8f3 8#d3 8f3 8#g3 16f3 8#d3 16- 8f3 16c3 16c3 16c3 16c3 8#a2 4c3 16c3 16c3 16c3 8c3"
var mk_theme = "8a1 8a1 8c2 8a1 8d2 8a1 8e2 8d2 8c2 8c2 8e2 8c2 8g2 8c2 8e2 8c2 8g1 8g1 8b1 8g1 8c2 8g1 8d2 8c2 8f1 8f1 8a1 8f1 8c2 8f1 8c2 8b1"
var test = "4e2 2- 16e2 16- 16e2 16- 16e2 16- 16e2 16- 4e2 4d2 4f2 8e2 4e2 16- 8d2 8f2 4e2 4c2 4- 8a1 8b1 8c2 8d2 4e2 16- 4e2 16e2 16- 16e2 16- 16e2 16- 8e2 8d2 4- 4f2 8e2 4e2 8d2 4c2 8b1 4c2 16-"
var test2 = "8c3 4#d3 8f3 8#d3 8f3 4c3 4c3 8#d3 8f3 8#d3 4g3 8- 8c3 4#d3 8f3 8#d3 8f3 4c3 4c3 8f3 8g3 8f3 4#g3 8-"

enum MTime {PAUSE, SAMPLE}

var note_names = [
	"a1",
	"a2",
	"a3",
	"a#1",
	"a#2",
	"b1",
	"b2",
	"c1",
	"c2",
	"c3",
	"c#1",
	"c#2",
	"c#3",
	"d1",
	"d2",
	"d3",
	"d#1",
	"d#2",
	"d#3",
	"e1",
	"e2",
	"e3",
	"f1",
	"f2",
	"f3",
	"f#1",
	"f#2",
	"f#3",
	"g1",
	"g2",
	"g3",
	"g#1",
	"g#2",
	"g#3"
]
# {"pause":1500/8}
# {"sample":[1500/4,"d#3"]}
# 
var melody_data = []
export(Array, AudioStreamSample) var samples

var is_playing := false

var regex_pause := RegEx.new()
var regex_duration := RegEx.new()
var regex_note := RegEx.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	print(note_names.size())
	regex_pause.compile("(\\d?.)-")
	regex_note.compile("#?(\\w)(?<!\\d).")
	code_parser(scatman)
	is_playing = true

	var melody = melody_data.duplicate(true)
	while not melody.empty():
		var p = melody.pop_back()
		var time := 0.0
		match p.keys()[0]:
			MTime.PAUSE:
				$sample.stop()
				time = p[MTime.PAUSE] / 1000.0
			MTime.SAMPLE:
				time = p[MTime.SAMPLE][0] / 1000.0
				var sample_id = note_names.find(p[MTime.SAMPLE][1])
				print(sample_id)
				$sample.stream = samples[sample_id]
				$sample.play()
		yield(get_tree().create_timer(time), "timeout")

func part(note:String):
	var p = regex_pause.search(note)
	var result_p
	if p != null:
		result_p = note.to_float()
		return {MTime.PAUSE:1500/result_p}
	var result_n
	var result_d
	var n = regex_note.search(note) 
	if n != null:
		n = n.get_string()
		result_d = note.split(n)[0].to_float()
		print(result_d)
		if "#" in n:
			var n0 = n[0]
			n[0] = n[1]
			n[1] = n0 
		result_n = n
	return {MTime.SAMPLE:[1500/result_d, result_n]}
	
func code_parser(code:String):
	var part = code.split(" ")
	for n in part:
		melody_data.append(part(n))
#		print(part(n))
	print(melody_data)
	melody_data.invert()

#func get_note_names(path:String):
#	var dir = Directory.new()
#	dir.open(path)
#	dir.list_dir_begin()
#
#	while true:
#		var file = dir.get_next()
#		if file == "":
#			break
#		elif file.ends_with("wav"):
#			note_names.append(file.split(".")[0])
#	dir.list_dir_end()
#	print(note_names)
