extends Node2D


enum {MAIN, WOOSH, WITHDRAW, COLLIDE, OVER,GAME, WALKING,CONGRATS}
func play(inp): 
	var audio = null 
	match inp: 
		MAIN: audio = $MainTheme
		WOOSH: audio = $Woosh
		WITHDRAW: audio = $Withdraw
		COLLIDE: audio = $Collide 
		OVER: audio = $GameOver
		GAME: audio = $GameTheme
		WALKING: audio = $Walking
		CONGRATS: audio = $Congrats
	audio.play()
func stop_all(): 
	for child in get_children(): 
		child.stop()
