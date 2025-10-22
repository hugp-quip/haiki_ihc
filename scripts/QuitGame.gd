extends Executable

static func execute(_tree : SceneTree) -> void:
	await Util.printToHUD("Saindo do jogo!")
	_tree.quit()
	
