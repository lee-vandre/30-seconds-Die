extends Node3D

@onready var die := $Die

var is_button_pressed: bool = false
var exponentialIncrease: float = 1.0
var initialPos = Vector3(1, 1, 1)
const maxIncrease: float = 100.0
var rng = RandomNumberGenerator.new()
@onready var floor_check_raycast =$box/RayCast3D
# Maximum allowed impulse and torque
const max_force: float = 50.0  # Adjust this value as needed


func is_on_floor() -> bool:
	return floor_check_raycast.is_colliding()
	

func _on_roll_button_down() -> void:
	if is_on_floor():
		is_button_pressed = true
	pass # Replace with function body.


func _on_roll_button_up() -> void:
	if is_on_floor():
		is_button_pressed = false
		
		var minTorque = 20.0
		var a = rng.randf_range(0, 30)
		var b = rng.randf_range(0, 30)
		var c = rng.randf_range(0, 30)
		
		# Create the impulse vector
		var impulse = Vector3(a, b, c)
		
		# Clamp the impulse to the max_force
		if impulse.length() > max_force:
			impulse = impulse.normalized() * max_force
		
		die.apply_impulse(impulse)
		
		# Apply torque with a similar clamping logic if needed
		var torque_impulse = Vector3(a * minTorque + exponentialIncrease, minTorque + exponentialIncrease, c * minTorque + exponentialIncrease)
		if torque_impulse.length() > max_force:
			torque_impulse = torque_impulse.normalized() * max_force
		
		die.apply_torque_impulse(torque_impulse)
		
		exponentialIncrease = 1.0
		pass # Replace with function body.


func _process(delta: float) -> void:
	if is_button_pressed:
		if exponentialIncrease < maxIncrease:
			exponentialIncrease += exponentialIncrease * delta
			print("increase", exponentialIncrease)


func _on_reset_button_down() -> void:
	die.position = initialPos
	die.linear_velocity = Vector3.ZERO
	die.angular_velocity = Vector3.ZERO
	pass # Replace with function body.
