extends Node2D

# Map Processor for Project Protean
# Handles map generation and tile management

func _ready():
	print("Map Processor initialized!")
	print("Project Protean - Map System Ready")
	
	# Test that the main scene system is working
	var main_node = get_tree().get_root().get_node("Main")
	if main_node:
		print("Main node found: ", main_node.name)
	else:
		print("Warning: Main node not found")

func _process(_delta):
	# Basic process loop for map updates
	pass