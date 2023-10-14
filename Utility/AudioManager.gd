extends Node2D


enum {MAIN, WOOSH, WITHDRAW, COLLIDE, OVER}
func play(inp): 
	var audio = null 
	match inp: 
		MAIN: audio = $MainTheme
		WOOSH: audio = $Woosh
		WITHDRAW: audio = $Withdraw
		COLLIDE: audio = $Collide 
		OVER: audio = $GameOver
	audio.play()
func stop_all(): 
	for child in get_children(): 
		child.stop()
