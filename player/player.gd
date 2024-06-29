extends RigidBody3D

@export_range(500.0, 2000.0) var boost := 1000.0


@export var rotation_speed := 160.0

#Audioф
@onready var lost: AudioStreamPlayer = $LostAudio
@onready var won: AudioStreamPlayer = $WonAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio

#Particles
@onready var center_boost: GPUParticles3D = $CenterBoost
@onready var right_boost: GPUParticles3D = $RightBoost
@onready var left_boost: GPUParticles3D = $LeftBoost
@onready var lost_particles: GPUParticles3D = $LostParticles
@onready var won_particles: GPUParticles3D = $WonParticles


var is_transitioning: bool = false


func _ready() -> void:
    while true:
        await get_tree().create_timer(0.01).timeout

func _physics_process(delta: float) -> void:
    $Label.text = "FPS: " + str(Engine.get_frames_per_second())
    
    if Input.is_action_pressed("boost"):
        apply_central_force(basis.y * delta * boost)
        center_boost.emitting = true
        if rocket_audio.playing == false:
            rocket_audio.play()
    else:
        rocket_audio.stop()
        center_boost.emitting = false
        
    if Input.is_action_pressed("left"):
        #apply_torque(Vector3(0.0, 0.0, 100.0 * delta))
        apply_torque(-Vector3.FORWARD * delta * rotation_speed)
        right_boost.emitting = true
    else:
        right_boost.emitting = false
        
    if Input.is_action_pressed("right"):
        apply_torque(Vector3.FORWARD * delta * rotation_speed)
        left_boost.emitting = true
    else:
        left_boost.emitting = false

    if Input.is_action_just_pressed("quit"):
        get_tree().quit.call_deferred()

func _on_body_entered(body: Node) -> void:
    if is_transitioning == false:
        if "Win" in body.get_groups():
            complete_level.call_deferred(body.file_path)
        if "Hazard" in body.get_groups():
            crash_sequence.call_deferred()


func crash_sequence() -> void:
    lost.play()
    lost_particles.emitting = true
    set_process(false)
    is_transitioning = true
    var tween = create_tween()
    tween.tween_interval(2.5)
    tween.tween_callback(get_tree().reload_current_scene)
    
func complete_level(next_level_scene : String) -> void:
    won.play()
    won_particles.emitting = true
    set_process(false)
    is_transitioning = true
    var tween = create_tween()
    tween.tween_interval(1.5)
    tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_scene))

