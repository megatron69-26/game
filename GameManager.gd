extends Node3D

@export var card_template : PackedScene

# Lấy toạ độ cái Marker3D mà bạn vừa cắm
@onready var spawn_point = $"tabletop standalone export2/playing cards/DeckSpawnPoint"

func _ready():
	print("Game Bắt Đầu! Đang chuẩn bị chia bài...")
	
func _input(event):
	# Bấm phím Space để test chia bài
	if event.is_action_pressed("ui_accept"): 
		chia_bai()

func chia_bai():
	if card_template == null:
		print("LỖI: Bạn chưa kéo file Card3D.tscn vào ô Card Template của GameManager!")
		return
		
	print("Bắt đầu phóng bài!")
	for i in range(5): # Chia 5 lá
		var la_bai = card_template.instantiate()
		add_child(la_bai)
		
		# Đặt lá bài xuất phát từ đúng vị trí Cọc Bài
		la_bai.global_position = spawn_point.global_position
		
		# Tính vị trí đích đến (Bay lơ lửng trước mặt Player, dàn ngang ra)
		# Tạm thời set toạ độ này, bạn có thể chỉnh sau
		var dich_den = Vector3(-2.0 + (i * 1.0), 1.5, 2.0)
		
		# Dùng Tween để tạo hiệu ứng lá bài bay vèo ra (Thời gian bay 0.4s)
		var tween = create_tween()
		tween.tween_property(la_bai, "global_position", dich_den, 0.4).set_delay(i * 0.1)
		
		# Cập nhật lại gốc toạ độ cho lá bài sau khi bay xong để nó biết chỗ Hover
		tween.tween_callback(func(): la_bai.original_pos = dich_den)
