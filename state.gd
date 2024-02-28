extends Node

class_name State

var playback
var player
var next_state: State

func setup(playback, player):
	self.playback = playback
	self.player = player

func state_process(_delta):
	pass
	
func state_input(_event: InputEvent):
	pass

func on_exit():
	pass

func on_enter():
	pass
