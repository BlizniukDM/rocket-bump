extends Control


func _on_start_button_pressed() -> void:
    get_tree().change_scene_to_file.call_deferred("res://levels/level_01.tscn")
    
func _on_quit_button_pressed() -> void:
    get_tree().quit()


func _on_selecter_pressed() -> void:
    get_tree().change_scene_to_file.call_deferred("res://levels/selecter_levels.tscn")
