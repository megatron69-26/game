extends Area3D

var original_pos : Vector3
var target_pos : Vector3

func _ready():
	original_pos = position
	target_pos = position
	
	# Kết nối tín hiệu chuột (Godot 4)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(delta):
	# Làm mượt chuyển động bằng Lerp
	position = position.lerp(target_pos, delta * 10.0)

func _on_mouse_entered():
	# Nhô lên theo trục Y khi chuột lướt qua
	target_pos = original_pos + Vector3(0, 0.2, 0.1) 

func _on_mouse_exited():
	# Tụt xuống lại khi chuột đi khỏi
	target_pos = original_pos

func _input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Bạn vừa bốc 1 lá bài!")
		# Đổi màu hoặc đánh dấu lá bài đã chọn
		target_pos = original_pos + Vector3(0, 0.5, -0.5) 
