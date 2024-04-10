extends Control

func _on_level_1_pressed() -> void:
    get_tree().change_scene_to_file.call_deferred("res://levels/level_01.tscn")


func _on_level_2_pressed() -> void:
    get_tree().change_scene_to_file.call_deferred("res://levels/level_02.tscn")


func _on_level_3_pressed() -> void:
    get_tree().change_scene_to_file.call_deferred("res://levels/level_03.tscn")


func _on_level_4_pressed() -> void:
    get_tree().change_scene_to_file.call_deferred("res://levels/level_04.tscn")


func _on_level_5_pressed() -> void:
    get_tree().change_scene_to_file.call_deferred("res://levels/level_05.tscn")


func _on_level_6_pressed() -> void:
    get_tree().change_scene_to_file.call_deferred("res://levels/level_06.tscn")


func _on_level_7_pressed() -> void:
    get_tree().change_scene_to_file.call_deferred("res://levels/level_07.tscn")
