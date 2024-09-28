extends Node3D

@onready var die:= $Die

var is_button_pressed:bool=false;
var exponentialIncrease :int= 1;

const maxIncrease :int = 100;


func _on_roll_button_down() -> void:
	is_button_pressed = true
	
	pass # Replace with function body.


func _on_roll_button_up() -> void:
	is_button_pressed = false
	var minTorque =20
	die.apply_impulse(Vector3(10,3,3))
	die.apply_torque(Vector3(minTorque+exponentialIncrease,3,3))
	exponentialIncrease=1
	print("Reached Maximum Value:", maxIncrease)
	pass # Replace with function body.

func _process(delta: float) -> void:
	if is_button_pressed:
		if exponentialIncrease < maxIncrease:
			exponentialIncrease = exponentialIncrease *delta
			print(exponentialIncrease)
