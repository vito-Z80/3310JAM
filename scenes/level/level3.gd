extends Node2D

# звуки:
# селект (выбор в меню / рюкзаке)
# интер
# соприкосновение с огнем факела
# умер от факела
# прыжок
# утонул
# выбор предмета в сумке / подобрал предмет 
# проворачивание кривого (starter handle)
# работающий механизм
# исчезновение / появление диззи в дымке
# 
# музыка:
# в меню
# в игре
# финальная сцена
# гейм овер - короткая негативная мелодия

# TODO когда диззи мертвый лежит на земле - СУМКУ МОЖНО ОТКРЫТЬ - нинада так

func _enter_tree():
	g.is_game_over = false
	g.is_end = false
	g.camera = $camera
	g.camera.current = true
	g.dizzy = $Dizzy
	g.bag = $backpack
#	g.bag.clear()
	g.dizzy.direction = 0
	g.dizzy.velocity.x = 0
#	g.dizzy.position = Vector2(-326, 84)
#	g.dizzy.animation.play("idle")
	g.lifes = 3
	g.is_end = false
#	$lifes.hp.rect_size.x = 16

func _process(delta):
	if g.is_game_over:
		get_tree().change_scene("res://scenes/game over/game_over.tscn")
