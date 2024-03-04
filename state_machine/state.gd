extends Node

class_name State

var playback
var player
var next_state: State
var move_component

signal interrupt_state(new_state:State)

func setup(playback, player, move_component):
	self.playback = playback
	self.player = player
	self.move_component = move_component

func state_process(_delta):
	pass
	
func state_input(_event: InputEvent):
	pass

func on_exit():
	pass

func on_enter():
	pass
