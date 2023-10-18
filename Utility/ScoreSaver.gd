extends Node
var score_file = "user://highscore.txt"

func load_score():
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		var content = f.get_as_text()
		if content == "": 
			return 0 
		var highscore = int(content)
		f.close()
		return highscore

# call this at game end to store a new highscore
func save_score(_score):
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(str(_score))
	f.close()
